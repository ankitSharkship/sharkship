// lib/screens/digilocker_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sharkship/features/kyc/presentation/servieces/digilocker_deep_link_service.dart';

class DigiLockerScreen extends StatefulWidget {
  /// The Cashfree URL from your API response — e.g.
  /// https://verification.cashfree.com/dgl?shortCode=a4att13dfkhg
  final String digilockerUrl;

  /// The verification_id from your API response
  final String verificationId;

  /// Called when user completes consent — passes verificationId back
  final void Function(String verificationId) onSuccess;

  /// Called when Cashfree returns a failure/error status
  final VoidCallback onFailure;

  /// Called when user taps the X button
  final VoidCallback onCancel;

  const DigiLockerScreen({
    super.key,
    required this.digilockerUrl,
    required this.verificationId,
    required this.onSuccess,
    required this.onFailure,
    required this.onCancel,
  });

  @override
  State<DigiLockerScreen> createState() => _DigiLockerScreenState();
}

class _DigiLockerScreenState extends State<DigiLockerScreen> {
  // ── Intercept targets ─────────────────────────────────────────────────────

  // Your web app's onboarding URL — Cashfree redirects here on completion
  static const String _webRedirect = 'app.sharkship.in/onboarding';

  // Cashfree's own sentinel URL — also watch for this as a fallback
  static const String _cashfreeSentinel =
      'verification.cashfree.com/dgl/status';

  // ── State ─────────────────────────────────────────────────────────────────

  bool _isLoading = true;

  /// Guards against duplicate completion calls (both shouldOverride and
  /// onLoadStop can fire for the same URL)
  bool _completionHandled = false;

  // ─────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    // Register to receive the deep link when DigiLocker native app returns
    // DigilockerDeepLinkService().onDeepLink = _handleNativeAppReturn;
  }

  @override
  void dispose() {
    // DigilockerDeepLinkService().onDeepLink = null;
    super.dispose();
  }

  // // ── Flow A: DigiLocker native app installed ───────────────────────────────
  // // DigiLocker app finishes and calls sharkship://digilocker/callback?...
  // void _handleNativeAppReturn(Uri uri) {
  //   debugPrint('[DigiLocker] Native app returned: $uri');

  //   // DigiLocker typically appends ?code=xxx&state=xxx on success
  //   // Absence of an "error" param is treated as success
  //   final isError = uri.queryParameters.containsKey('error');
  //   _finalise(success: !isError);
  // }

  // ── Flow B: WebView-only — Cashfree redirects to your web URL ────────────
  void _handleRedirectUrl(String url) {
    debugPrint('[DigiLocker] Redirect intercepted: $url');

    // Parse any status params Cashfree may have appended
    final uri = Uri.parse(url);
    final status = uri.queryParameters['status'];

    // If there's an explicit status, honour it; otherwise treat redirect as success
    final success =
        status == null || status == 'success' || status == 'SUCCESS';
    _finalise(success: success);
  }

  // ── Common completion handler ─────────────────────────────────────────────
  void _finalise({required bool success}) {
    if (_completionHandled) return; // idempotency guard
    _completionHandled = true;

    debugPrint('[DigiLocker] Finalising — success: $success');

    // Use Future.microtask instead of addPostFrameCallback
    // Microtask runs before the next shouldOverrideUrlLoading can fire
    Future.microtask(() {
      if (!mounted) return;
      Navigator.of(context).pop();
      if (success) {
        widget.onSuccess(widget.verificationId);
      } else {
        widget.onFailure();
      }
    });
  }

  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Aadhaar'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (_completionHandled) return;
            _completionHandled = true;
            Navigator.of(context).pop();
            widget.onCancel();
          },
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.digilockerUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              // MUST be true — without this shouldOverrideUrlLoading never fires on Android
              useShouldOverrideUrlLoading: true,
              // Allows DigiLocker's mixed HTTP/HTTPS internal redirect chain
              mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
              // Register digilocker:// so Android WebView passes it to shouldOverride
              resourceCustomSchemes: ['digilocker'],
            ),
            onLoadStart: (controller, url) {
              setState(() => _isLoading = true);
            },
            onLoadStop: (controller, url) {
              setState(() => _isLoading = false);
              // Fallback check — in rare cases shouldOverride fires but page
              // still loads; this catches it
              // final raw = url?.toString() ?? '';
              // if (raw.contains(_webRedirect) ||
              //     raw.contains(_cashfreeSentinel)) {
              //   _handleRedirectUrl(raw);
              // }
            },
            // ── PRIMARY interception — fires BEFORE any page loads ──────────
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = navigationAction.request.url?.toString() ?? '';

              debugPrint('[DigiLocker] Navigating to: $url');

              // 1. DigiLocker native app deep link (Flow A)
              //    WebView hits digilocker:// or Android intent:// wrapper
              debugPrint('[DigiLocker] >>> URL: $url');
              debugPrint(
                '[DigiLocker] >>> isForMainFrame: ${navigationAction.isForMainFrame}',
              );

              if (url.startsWith('digilocker://') ||
                  url.startsWith('intent://')) {
                final appUri = Uri.parse(url);
                // Launch async but don't await before returning CANCEL
                unawaited(
                  launchUrl(appUri, mode: LaunchMode.externalApplication),
                );
                return NavigationActionPolicy.CANCEL;
              }

              // 2. Your web app's onboarding URL — Cashfree's redirect_url (Flow B)
              if (url.contains(_webRedirect)) {
                _handleRedirectUrl(url);
                return NavigationActionPolicy.CANCEL;
              }

              // 3. Cashfree sentinel URL — secondary fallback (Flow B)
              if (url.contains(_cashfreeSentinel)) {
                _handleRedirectUrl(url);
                return NavigationActionPolicy.CANCEL;
              }

              // Allow everything else — DigiLocker's own pages, OTP screens, etc.
              return NavigationActionPolicy.ALLOW;
            },
            onReceivedError: (controller, request, error) {
              // Ignore sub-frame errors (analytics, fonts inside DigiLocker pages)
              if (request.isForMainFrame == true) {
                debugPrint('[DigiLocker] WebView error: ${error.description}');
              }
            },
          ),

          // Loading overlay
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
