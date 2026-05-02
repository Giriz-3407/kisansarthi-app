# KisanSarthi Flutter Build Specification

This document is a **Flutter implementation blueprint** derived from the current KisanSarthi project.  
Use it as the single source of truth when rebuilding the app in Flutter.

---

## 1) Product Goal

Build a farmer-facing mobile app that provides:
- Farm and land management
- Soil data capture (manual + IoT ingestion support via backend)
- AI crop suggestions
- AI fertilizer recommendations
- Plant disease scan and diagnosis
- Market price checks and weather context

Target users: smallholder farmers, multilingual usage, low-friction workflows.

---

## 2) Existing System Snapshot (Source of Truth)

- Frontend (current): React Native + Expo
- Backend: Flask (`backend/app.py`)
- DB: SQLite (`backend/farm_app.db`, schema in `backend/create_db.py`)
- AI modules: `backend/agents/*`

Your Flutter app should be a functional equivalent of current frontend behavior, calling existing backend APIs.

---

## 3) Flutter App Scope (Must Have)

### 3.1 Auth
- Register (name, phone, password)
- Login (phone, password)
- Store token securely
- Auto-login on app reopen
- Logout

### 3.2 Farm Management
- List farms
- Create farm
- View farm details
- Update/Delete farm
- Upload farm image

### 3.3 Land Management
- Add land under farm
- List lands by farm
- Land detail view
- Update/Delete land

### 3.4 Soil Workflows
- Manual soil reading entry (N, P, K, pH, moisture, temperature, humidity, rainfall if needed)
- View latest/historical readings
- Support device-assigned land indicators

### 3.5 AI Recommendations
- Crop suggestions for land
- Start planting using selected crop
- Fertilizer recommendations for active planting + latest soil

### 3.6 Disease Diagnosis
- Capture image from camera/gallery
- Upload scan request
- Poll diagnosis log until completed
- Display disease details and remedies

### 3.7 Utilities
- Market price query by crop/location
- Weather fetch by lat/lon
- Profile screen with user edit

---

## 4) Recommended Flutter Tech Stack

- **State management**: Riverpod (preferred) or Bloc
- **Routing**: `go_router`
- **Networking**: `dio`
- **Serialization**: `json_serializable` + `freezed`
- **Storage**:
  - token: `flutter_secure_storage`
  - simple prefs/cache: `shared_preferences`
- **Localization**: `intl` + ARB-based localization
- **Image capture/pick**: `image_picker`
- **Permissions**: `permission_handler`
- **Form validation**: `formz` or custom validators
- **Charts (soil history optional)**: `fl_chart`

---

## 5) Project Structure (Flutter)

```text
lib/
  main.dart
  app.dart
  core/
    config/
    constants/
    errors/
    network/
    storage/
    utils/
  l10n/
  features/
    auth/
      data/
      domain/
      presentation/
    dashboard/
    farms/
    lands/
    soil/
    recommendations/
    diagnostics/
    market/
    profile/
  shared/
    widgets/
    models/
```

Architecture pattern: **Feature-first Clean-ish architecture**  
(Data -> Domain -> Presentation), with pragmatic simplification allowed.

---

## 6) Navigation Map (Flutter Routes)

### 6.1 Unauthenticated
- `/register`
- `/login`

### 6.2 Authenticated shell (bottom tabs)
- `/dashboard`
- `/scan`
- `/profile`

### 6.3 Stack routes
- `/farms/add`
- `/farms/:farmId`
- `/farms/:farmId/lands/add`
- `/lands/:landId`
- `/lands/:landId/manual-soil`
- `/lands/:landId/crop-suggestions`
- `/lands/:landId/crop-suggestions/:cropName` (detail)
- `/lands/:landId/fertilizer`
- `/lands/:landId/soil-monitoring`
- `/lands/:landId/link-device`
- `/market`
- `/diagnostics/result/:logId`

---

## 7) Backend API Contracts (Implement Exactly)

Base URL:
- Web/dev: `http://127.0.0.1:5000/api/v1`
- Device: `http://<your-local-ip>:5000/api/v1`

Auth header:
- `Authorization: Bearer <token>`

### 7.1 Auth
- `POST /auth/register`
  - req: `{ name, phone_number?, password }`
  - res: `{ user, token }`
- `POST /auth/login`
  - req: `{ email_or_phone, password }`
  - res: `{ user, token }`

### 7.2 User
- `GET /users/me`
- `PUT /users/me`

### 7.3 Farms
- `POST /farms`
- `GET /farms?limit=&offset=`
- `GET /farms/{farmId}`
- `PUT /farms/{farmId}`
- `DELETE /farms/{farmId}`
- `POST /farms/{farmId}/image` (multipart)
- `GET /courses?limit=&offset=`

### 7.4 Lands
- `POST /farms/{farmId}/lands`
- `GET /farms/{farmId}/lands?limit=&offset=`
- `GET /lands/{landId}`
- `PUT /lands/{landId}`
- `DELETE /lands/{landId}`

### 7.5 Hardware Devices
- `POST /hardware_devices`
- `GET /farms/{farmId}/hardware_devices`
- `GET /hardware_devices/{deviceId}`
- `PUT /hardware_devices/{deviceId}`
- `PUT /hardware_devices/{deviceId}/assignment`
- `DELETE /hardware_devices/{deviceId}`

### 7.6 Soil
- `GET /lands/{landId}/soil-readings`
- `POST /lands/{landId}/manual-soil-reading`

### 7.7 Plantings
- `POST /lands/{landId}/plantings`
- `GET /plantings/{plantingId}`
- `PUT /plantings/{plantingId}`
- `DELETE /plantings/{plantingId}`

### 7.8 Diagnostics
- `POST /diagnostics/scan-plant` (multipart: image + optional land_id/planting_id/lang)
- `GET /diagnostics/logs/{logId}`
- `GET /diagnostics/logs`

### 7.9 Recommendations and reference
- `GET /lands/{landId}/crop-suggestions?lang=`
- `GET /lands/{landId}/fertilizer-recommendations?lang=`
- `GET /recommendations`
- `PUT /recommendations/{id}/status`
- `GET /crops`
- `GET /diseases`
- `GET /fertilizers`
- `GET /market/prices?crop=&location=&lang=`
- `GET /weather?lat=&lon=`

---

## 8) Flutter Data Models (Create These First)

At minimum:
- `AuthResponse { user, token }`
- `User`
- `Farm`
- `Land`
- `HardwareDevice`
- `SoilReading`
- `Planting`
- `CropSuggestion`
- `FertilizerRecommendation`
- `DiagnosisLog`
- `Disease`
- `Remedy`
- `MarketPrice`
- `RecommendationItem`

Notes:
- Keep nullable fields nullable (backend has many optional columns).
- Add `fromJson/toJson`.
- Include flexible parsing for inconsistent keys if backend returns mixed styles.

---

## 9) Feature-by-Feature Functional Specs

## 9.1 Auth Module
- On successful login/register:
  1. save token
  2. set authenticated state
  3. navigate to dashboard shell
- On app start:
  - read token
  - if exists, fetch `/users/me` for session validation

## 9.2 Dashboard Module
- Fetch:
  - user profile
  - farms list
  - optional recommendations preview
- UI:
  - quick actions: add farm, open scan, open profile

## 9.3 Farm Module
- Farm list cards with:
  - farm name
  - location/address summary
  - number of lands/devices if available
- Farm details:
  - farm image
  - lands list
  - actions: add land, upload image, delete farm

## 9.4 Land Module
- Land details should display:
  - current planting status
  - assigned device status
  - latest soil reading snapshot
  - quick action buttons

## 9.5 Soil Module
- Manual input form:
  - N/P/K/pH/moisture/temperature/humidity
  - validations (numeric range + required fields)
  - optional weather autofill using `/weather`
- Soil history:
  - fetch paginated readings
  - allow date filtering if needed

## 9.6 Crop Suggestion Module
- Fetch from `/lands/{id}/crop-suggestions`
- Show:
  - crop name
  - match/suitability
  - explanation
  - expected yield/growing season if present
- Actions:
  - start planting via `/lands/{id}/plantings`
  - open details page

## 9.7 Fertilizer Module
- Preconditions:
  - land exists
  - active planting exists (or handle gracefully)
- Fetch and display:
  - fertilizer name/product
  - dosage/amount
  - buy-at and price metadata if available
  - concise explanation and advisory note

## 9.8 Diagnostics Module
- Image upload:
  - camera/gallery chooser
  - show preview before submit
- Submit scan:
  - call `/diagnostics/scan-plant`
  - save `log_id`
- Poll loop:
  - query `/diagnostics/logs/{logId}` every 2-3s until status terminal
  - stop polling on dispose
- Render result:
  - disease, confidence, symptoms
  - remedies list
  - prevention tips

## 9.9 Market Module
- Inputs:
  - crop (required)
  - location (optional)
- Fetch from `/market/prices`
- Show list/table cards with source/date/price if present.

## 9.10 Profile Module
- Fetch `/users/me`
- Edit via `/users/me` PUT
- Logout clears secure token and resets navigation stack.

---

## 10) State Management Blueprint (Riverpod Example)

Global providers:
- `authStateProvider`
- `dioClientProvider` (inject token interceptor)
- `apiServiceProvider`

Feature providers:
- `farmsNotifierProvider`
- `farmDetailNotifierProvider(farmId)`
- `landDetailNotifierProvider(landId)`
- `soilReadingsNotifierProvider(landId)`
- `cropSuggestionsProvider(landId, lang)`
- `fertilizerProvider(landId, lang)`
- `diagnosisPollingNotifierProvider(logId)`

Use `AsyncValue` states:
- loading
- data
- error (with backend message)

---

## 11) Error Handling Requirements

Must handle:
- 400 validation errors -> inline form messages
- 401 unauthorized -> force logout and navigate to login
- 404 -> empty/not found states
- 409 conflicts -> user-friendly action guidance
- network timeout/no internet -> retry UI with cached fallback where possible

Backend returns message/description patterns; normalize into one user-visible error model.

---

## 12) Localization Requirements

Current app supports multilingual content requests (`lang` query/form value).

Flutter localization tasks:
- ARB files for app labels
- runtime language switcher
- pass selected language to:
  - crop suggestions endpoint
  - fertilizer recommendation endpoint
  - diagnostics scan endpoint (lang field)
  - market prices endpoint

---

## 13) UI/UX Requirements

Screens should be:
- touch-friendly for field usage
- readable with high contrast
- resilient for long translated text
- clear with loading skeletons/spinners
- explicit with success/error toasts

Required reusable widgets:
- `AppScaffold`
- `PrimaryButton`, `SecondaryButton`
- `LabeledTextField`, `NumericField`
- `InfoCard`, `StatusChip`
- `EmptyStateView`, `ErrorStateView`
- `RetryButton`

---

## 14) Security and Config Requirements

Current backend auth is demo-grade. Flutter app should still implement best client practices:
- Never hardcode tokens
- Keep base URLs in environment config (`--dart-define`)
- Use secure token storage
- Add request timeout and SSL handling for production
- Do not log tokens or sensitive payloads in release

Config strategy:
- `flavor/dev`, `flavor/stage`, `flavor/prod`
- env variables:
  - `API_BASE_URL`
  - `REQUEST_TIMEOUT_MS`
  - `ENABLE_VERBOSE_LOGS`

---

## 15) Testing Plan (Flutter)

Unit tests:
- model serialization
- repository method mapping
- validation logic

Widget tests:
- auth forms
- farm/land cards rendering
- error/empty/loading states

Integration tests:
- login -> dashboard
- add farm -> add land -> manual soil entry
- crop suggestion fetch and planting start
- diagnostics upload + polling flow

---

## 16) Build Order (Implementation Roadmap)

1. Project scaffold + env config + Dio client
2. Auth feature + secure storage
3. Dashboard + farms list/add/detail
4. Land add/detail + manual soil
5. Crop suggestion + planting
6. Fertilizer recommendations
7. Scan + diagnosis polling
8. Market + profile
9. Localization and polish
10. Test hardening + release build

---

## 17) Known Backend Caveats You Must Accommodate

- Token is a demo format (`demo-token-user-{id}`).
- Some responses may have inconsistent field naming/history.
- Diagnostics processing may complete during `GET /diagnostics/logs/{id}` call (can be slow).
- Local IP must be configurable, not hardcoded in Flutter.

Design the Flutter client to be tolerant, with robust parsing and retries.

---

## 18) Done Criteria (Definition of Complete)

The Flutter app is complete when:
- All flows in section 3 are implemented and usable.
- API calls in section 7 are integrated and tested.
- App is stable for no-data, slow-network, and backend-error conditions.
- Language switching and `lang` propagation work end-to-end.
- Build runs on Android and iOS debug profiles.

---

## 19) Optional Enhancements (Post-MVP)

- Offline caching for farms/lands/readings
- Push notifications for recommendations/alerts
- Charts for nutrient trend visualization
- Better device onboarding wizard
- Role-based access (advisor/farmer)

---

This file is intended specifically for generating a Flutter application from the current KisanSarthi system.
