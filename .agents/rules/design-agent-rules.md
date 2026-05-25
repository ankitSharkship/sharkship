# Design System & Styling Architecture Standard (MANDATORY)

This document defines the strict visual rules, typography scales, color schemes, and custom context extensions to be followed by any development agent. Maintaining absolute aesthetic consistency and leveraging our standardized semantic tokens is non-negotiable.

---

## 1. Core Color System

The application relies on a modern, cohesive primary-blue design language. Under no circumstances should raw hex codes or direct `ColorManager` references be introduced in new files.

### 1.1 The Active Color Palette (`AppColors`)
* **Primary Blue:** `Color(0xFF184FA2)` — The core branding color (headers, primary cards, active state icons).
* **Secondary Blue:** `Color(0xFF27AAE2)` — Primary actions, active highlights, and state toggles.
* **Light Blue:** `Color(0xFF91D3EE)` — Subtext highlights, borders, and gradient stops.
* **Light Blue Bg:** `Color(0xFFE1EEF4)` — Background tints for cards, input fields, and icon wrappers.
* **Light Green:** `Color(0xFFE1FEEC)` — Success state backgrounds.
* **Scaffold Bg:** `Color(0xFFF5F5F5)` — The uniform default background for all application screens.

### 1.2 Gradient Colors
* **Primary Branding Gradient:** A smooth linear gradient transitioning from `0xFF184FA2` (primaryBlue) -> `0xFF27AAE2` (secondaryBlue) -> `0xFF91D3EE` (lightBlue).
* **Login/Authentication Gradient:** A vertical/horizontal gradient transitioning from `0xFF1E88C8` (loginGradientStart) -> `0xFF6EC1E4` (loginGradientEnd).

### 1.3 State-Specific Theme Colors
* **Success Solid:** `Color(0xFF34C759)` — Solid successes, icons, and dialog confirmations.
* **Error Solid:** `Color(0xFFD32F2F)` / `Color(0xFFFF0000)` — Failure icons, alerts, and field validations.
* **Error Background:** `Color(0xFFFFE5E5)` — Lightweight backgrounds for error alerts and container wrappers.

---

## 2. Typography Standard (`AppTextTheme`)

All typography must leverage the application's unified semantic text theme to ensure responsive scales and consistent weights.

### 2.1 The Typography Scale
* **Display / Main Headings:**
  * `displayLarge`: `fontSize: 32`, `fontWeight: FontWeight.w700` (bold titles)
  * `displayMedium`: `fontSize: 28`, `fontWeight: FontWeight.w700` (intermediate screens)
  * `titleLarge`: `fontSize: 20`, `fontWeight: FontWeight.w600` (screen headers/sheet headers)
* **Body Text:**
  * `bodyLarge`: `fontSize: 16`, `fontWeight: FontWeight.w400` (primary descriptions)
  * `bodyMedium`: `fontSize: 14`, `fontWeight: FontWeight.w400` (default text, subtext lists)
  * `bodySmall`: `fontSize: 12`, `fontWeight: FontWeight.w400` (captions, minor metadata)
* **Labels / Action Text:**
  * `labelLarge`: `fontSize: 14`, `fontWeight: FontWeight.w600` (primary button text, active selections)
  * `labelMedium`: `fontSize: 12`, `fontWeight: FontWeight.w500` (tab indicators)
  * `labelSmall`: `fontSize: 11`, `fontWeight: FontWeight.w500` (stat cards labels)

### 2.2 Text Style Usage Rules
* ❌ **Never** declare a raw `TextStyle` with hardcoded `fontSize` inside widget trees.
* ALWAYS fetch the base typography from the active theme: `Theme.of(context).textTheme.bodyMedium`.
* ALWAYS use `.copyWith()` to customize weights, line heights, or colors where required (e.g., `Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54)`).

---

## 3. BuildContext Extensions (`AppThemeX`)

We leverage type-safe context extensions to access theme tokens cleanly and consistently.

```dart
import 'package:sharkship/extensions/app_color_extensions.dart';
```

### 3.1 Standard Color Scheme Retrieval
Retrieve core material colors directly using:
* `context.colors.primary` (maps to `AppColors.primaryBlue`)
* `context.colors.secondary` (maps to `AppColors.secondaryBlue`)
* `context.colors.surface` (maps to white/container surface background)
* `context.colors.error` (maps to `Colors.red`)

### 3.2 Custom/Branded Colors Retrieval
Retrieve brand-specific accents using:
* `context.extraColors.lightBlueBg`
* `context.extraColors.lightGreen`
* `context.extraColors.scaffoldBg`
* `context.extraColors.primaryGradient` (for containers, buttons, active views)

---

## 4. Reusable Widgets & Component Patterns

### 4.1 Loading Activities
* ❌ **Never** introduce a default `CircularProgressIndicator` or random spinbox overlays.
* ALWAYS use `ThreeDotsLoader` (imported from `package:sharkship/shared/widgets/loader.dart`).
```dart
const ThreeDotsLoader(
  dotCount: 3,
  size: 12,
  activeColor: Colors.blue,
)
```

### 4.2 Standard Primary Buttons
* ALWAYS use `GradientButton` (imported from `package:sharkship/shared/widgets/gradient_button.dart`).
```dart
GradientButton(
  text: "Submit",
  onTap: () => _handleSubmit(),
  isActive: state.isFormValid, // Smooth opacity scale and automatic touch disabled state
)
```
* **Height:** Default is `56px` for primary interactions.
* **Shape:** Default border radius is `16.0` (`BorderRadius.circular(16)`).

### 4.3 Dialogs, Popups, and Alerts
* **Dialog Shape:** Always use `RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))` or `20` for standard sheets/dialogs.
* **Vertical Spacing:** Section spacing must standardly be `16`, `24`, or `28` inside content.
* **Standard dialog instances:**
  * **Success:** Use `SuccessDialog` with checkmark circle container (`Color(0xFF34C759)`) and white action button.
  * **Error:** Use `ErrorDialog` or `ErrorPopup` with red cross circle (`Color(0xFFFFE5E5)` background, `Color(0xFFD32F2F)` icon) to present critical alerts gracefully.
  * **Interactive Prompts:** Use `GlobalPopups.showAlert(...)` for actions requiring user choices.

### 4.4 Cards and Content Containers
* **Border Radius:** Default corner rounding is `12` or `16` (`BorderRadius.circular(12)`).
* **Borders:** Thin, cohesive light grey borders for high structural readability:
  `Border.all(color: const Color(0xFFE5E8EF), width: 1.5)`
* **Drop Shadows:** Avoid heavy shadows. Utilize soft, premium blur offsets:
  `BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))`
* **Primary Elevate Stop:** For primary brand-colored cards:
  `BoxShadow(color: AppColors.primaryBlue.withOpacity(0.30), blurRadius: 16, offset: const Offset(0, 6))`

---

## 5. Iconography and SVGs

* **Branded Icon Library:** Prefer using `HugeIcon` from the `hugeicons` package or the standard Material `Icon` family.
* **Dimensions:**
  * Standard card cells: `20` pixels.
  * Hero feature lists: `26` pixels.
* **Colors:** Icons must match primary/secondary themes or semantic states (`context.colors.primary`).
* **Vector Graphics:** Load SVG brand assets using `SvgPicture.asset(..., fit: BoxFit.contain)` from `package:flutter_svg/flutter_svg.dart`.

---

## 6. Layout & Responsive Principles

* **Screen Adaptivity:** Standardize dynamic widths/heights using `MediaQuery.of(context).size` ratios.
* **Paddings:** Prefer standard, symmetrical horizontal spacing: `EdgeInsets.symmetric(horizontal: 24)` or `18`.
* **Transitions:** Implement smooth view transitions. When dealing with loaders and error sheets, maintain layout consistency so elements don't shift abruptly.
