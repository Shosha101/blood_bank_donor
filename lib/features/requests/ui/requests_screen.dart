import 'package:blood_bank_donor/core/theming/app_theme.dart';
import 'package:blood_bank_donor/core/widgets/app_widgets.dart';
import 'package:blood_bank_donor/features/requests/data/model/request_model.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_cubit.dart';
import 'package:blood_bank_donor/features/requests/logic/requests_state.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

enum _RequestFilter { all, pending, accepted, declined }

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  bool _isLayoutReady = false;
  _RequestFilter _filter = _RequestFilter.all;

  /// Last list that loaded, kept on screen while an accept or decline is in flight.
  List<RequestModel>? _lastRequests;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLayoutReady = true;
      });
      if (!context.read<RequestsCubit>().isClosed) {
        context.read<RequestsCubit>().getDonationRequests();
      }
    });
  }

  void _reload() {
    if (_isLayoutReady && !context.read<RequestsCubit>().isClosed) {
      context.read<RequestsCubit>().getDonationRequests();
    }
  }

  void _accept(RequestModel request) {
    if (!context.read<RequestsCubit>().isClosed) {
      context.read<RequestsCubit>().approveDonationRequest(
        request.donorDonationRequestId,
      );
    }
  }

  void _decline(RequestModel request) {
    if (!context.read<RequestsCubit>().isClosed) {
      context.read<RequestsCubit>().rejectDonationRequest(
        request.donorDonationRequestId,
      );
    }
  }

  bool _matches(RequestModel request) {
    switch (_filter) {
      case _RequestFilter.all:
        return true;
      case _RequestFilter.pending:
        return request.donorApprovalStatus == null;
      case _RequestFilter.accepted:
        return request.donorApprovalStatus == true;
      case _RequestFilter.declined:
        return request.donorApprovalStatus == false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: context.tr('requests_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: BlocConsumer<RequestsCubit, RequestsState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (requests) => _lastRequests = requests,
                error: (error) {
                  // With a list on screen the error shows as a snackbar; otherwise the body shows it.
                  if (_lastRequests != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error.apiErrorModel.message ??
                              context.tr('requests_error'),
                        ),
                        backgroundColor: AppColors.primaryDark,
                      ),
                    );
                  }
                },
              );
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return state.when(
                initial: () => _buildLoading(),
                loading: () => _buildLoading(),
                success: (requests) => _buildList(requests, busy: false),
                error: (error) => _lastRequests != null
                    ? _buildList(_lastRequests!, busy: false)
                    : Center(
                        child: SingleChildScrollView(
                          child: StateMessage(
                            icon: Icons.cloud_off_outlined,
                            title: context.tr('requests_error'),
                            body: error.apiErrorModel.message,
                            actionLabel: context.tr('retry'),
                            onAction: _reload,
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    if (_lastRequests != null) return _buildList(_lastRequests!, busy: true);
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<RequestModel> requests, {required bool busy}) {
    final pending = requests.where((r) => r.donorApprovalStatus == null).length;
    final visible = requests.where(_matches).toList();

    return Column(
      children: [
        SizedBox(
          height: 3,
          child: busy ? const LinearProgressIndicator() : null,
        ),
        Expanded(
          child: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => _reload(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_downward_rounded,
                      size: 14,
                      color: AppColors.hint,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      context.tr('pull_to_refresh'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.hint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _PendingBanner(count: pending),
                const SizedBox(height: 14),
                _FilterBar(
                  selected: _filter,
                  onSelected: (filter) => setState(() => _filter = filter),
                ),
                const SizedBox(height: 14),
                if (visible.isEmpty)
                  StateMessage(
                    icon: Icons.inbox_outlined,
                    title: context.tr('empty_requests_title'),
                    body: requests.isEmpty
                        ? context.tr('empty_requests_body')
                        : context.tr('empty_filter_body'),
                  )
                else
                  for (final request in visible)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _RequestCard(
                        request: request,
                        enabled: _isLayoutReady && !busy,
                        onAccept: () => _accept(request),
                        onDecline: () => _decline(request),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PendingBanner extends StatelessWidget {
  final int count;
  const _PendingBanner({required this.count});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primarySoft,
      borderColor: AppColors.primarySoft,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('pending_banner_title'),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  context.plural('pending_banner_body', count),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final _RequestFilter selected;
  final ValueChanged<_RequestFilter> onSelected;

  const _FilterBar({required this.selected, required this.onSelected});

  static const _labels = {
    _RequestFilter.all: 'filter_all',
    _RequestFilter.pending: 'filter_pending',
    _RequestFilter.accepted: 'filter_accepted',
    _RequestFilter.declined: 'filter_declined',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in _RequestFilter.values)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: ChoiceChip(
                label: Text(context.tr(_labels[filter]!)),
                selected: selected == filter,
                onSelected: (_) => onSelected(filter),
                showCheckmark: false,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: selected == filter
                      ? AppColors.primary
                      : AppColors.border,
                ),
                shape: const StadiumBorder(),
                labelStyle: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected == filter ? Colors.white : AppColors.text,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final RequestModel request;
  final bool enabled;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _RequestCard({
    required this.request,
    required this.enabled,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final accepted = request.donorApprovalStatus == true;
    final declined = request.donorApprovalStatus == false;

    return AppCard(
      borderColor: accepted
          ? AppColors.success.withValues(alpha: 0.35)
          : AppColors.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BloodBadge(
                bloodType: request.bloodTypeName,
                background: accepted
                    ? AppColors.successSoft
                    : AppColors.primarySoft,
                foreground: accepted ? AppColors.success : AppColors.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.hospitalName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _MetaRow(
                      icon: Icons.location_on_outlined,
                      text: request.areaName,
                    ),
                    const SizedBox(height: 4),
                    _MetaRow(
                      icon: Icons.calendar_today_outlined,
                      text: formatApiDate(request.dateOfCreation),
                      ltr: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (accepted)
            _StatusStrip(
              icon: Icons.check_circle,
              text: context.tr('you_accepted'),
              background: AppColors.successSoft,
              foreground: AppColors.success,
            )
          else if (declined)
            _StatusStrip(
              icon: Icons.cancel_outlined,
              text: context.tr('you_declined'),
              background: AppColors.neutralSoft,
              foreground: AppColors.muted,
            )
          else
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FilledButton.icon(
                    onPressed: enabled ? onAccept : null,
                    icon: const Icon(Icons.favorite, size: 18),
                    label: Text(context.tr('accept')),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: enabled ? onDecline : null,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      foregroundColor: AppColors.text,
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: Text(context.tr('decline')),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool ltr;

  const _MetaRow({required this.icon, required this.text, this.ltr = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.muted),
        const SizedBox(width: 6),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              text,
              textDirection: ltr ? TextDirection.ltr : null,
              style: const TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusStrip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color background;
  final Color foreground;

  const _StatusStrip({
    required this.icon,
    required this.text,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
