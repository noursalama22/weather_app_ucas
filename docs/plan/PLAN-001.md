# PLAN-001: Weather App Implementation Plan

## 1. Executive Summary & Scope Boundary

This plan converts the approved weather app specification into a concrete, atomic delivery roadmap for a Flutter MVP built within a strict 2-hour window. The implementation will prioritize a single-screen weather dashboard, Clean Architecture separation, and Provider-based state management while staying tightly within the approved scope.

### Product Goal
Create a fast, reliable, cross-platform weather dashboard that allows users to:
- View current weather for their current detected location
- Search weather for a custom city
- Review a 5-day forecast in a single screen
- Toggle between English and Arabic with proper RTL/LTR behavior
- Handle loading and error states without leaving the dashboard

### Scope Boundary
In scope:
- iOS, Android, and Web via Flutter
- Clean Architecture with domain, data, and presentation layers
- Provider for state management
- OpenWeatherMap API integration
- Geolocator-based current location detection
- Single-screen responsive dashboard
- English and Arabic language support
- Error and retry handling in-place

Out of scope:
- Local persistence / offline database
- Favorites or saved cities
- Push notifications / background alerts
- Weather radar or map-based visualizations
- Additional screens, complex navigation, or advanced user personalization

### Delivery Principle
The project must remain intentionally small and reviewable. Work should be broken into milestones that align with the required Git checkpoints and be auditable in small, atomic changes.

---

## 2. Implementation Principles

### 2.1 Clean Architecture Rules
- Domain layer must not depend on Flutter widgets or UI classes
- Data layer must be responsible for API and location integration only
- Presentation layer must render state and handle user interactions only
- Repository interfaces belong in domain and implementations belong in data

### 2.2 State Management Rules
- Use Provider (ChangeNotifier or similar) as the central state owner
- Keep app state explicit for: loading, success, and error
- The UI must react to state changes without direct dependency on network code

### 2.3 Localization Rules
- Support English and Arabic through a lightweight locale switch
- Ensure UI direction and alignment adapt to RTL/LTR when the locale changes
- Send localized query parameters to the API with corresponding language values

### 2.4 MVP Guardrails
- One screen, one dashboard flow, no additional screens
- Keep API usage focused on current weather + forecast endpoints only
- Avoid feature creep beyond approved requirements

---

## 3. Phase-by-Phase Breakdown

## Phase 1: Project Initialization
Checkpoint: "chore: initialize weather app project"

### Objective
Establish the baseline Flutter project structure and ensure the repository is ready for Clean Architecture implementation.

### Affected Files
- pubspec.yaml
- analysis_options.yaml
- README.md
- lib/main.dart
- project structure under lib/
- docs/ (for plan/spec files)

### Changes Required
- Confirm Flutter SDK and package setup
- Add required dependencies for:
  - http or dio
  - provider
  - geolocator
  - maybe intl, flutter_localizations if needed
- Remove default demo app contents
- Define app entry point and base material app shell
- Add documentation placeholders for architecture and spec

### Deliverables
- Working Flutter project scaffold
- Dependencies aligned with MVP requirements
- Clean baseline ready for domain/data/presentation layering

### Acceptance Criteria
- Project builds in a stable Flutter state
- Dependencies required for the app are present
- Repo is clean, reviewable, and ready for architecture milestone

---

## Phase 2: Architecture Foundation
Checkpoint: "feat: add clean architecture foundation"

### Objective
Create the layered architecture skeleton without implementing business logic or UI behavior yet.

### Proposed File Structure
- lib/
  - core/
    - constants/
    - errors/
    - utils/
  - domain/
    - entities/
      - weather_entity.dart
    - repositories/
      - weather_repository.dart
  - data/
    - models/
      - weather_model.dart
    - datasources/
      - weather_remote_data_source.dart
    - services/
      - location_service.dart
    - repositories/
      - weather_repository_impl.dart
  - presentation/
    - providers/
      - weather_provider.dart
    - screens/
      - weather_dashboard_screen.dart
    - widgets/
      - weather_card.dart
      - forecast_list.dart
      - error_banner.dart
      - loading_indicator.dart
  - app.dart
  - main.dart

### Affected Files
- lib/domain/*
- lib/data/*
- lib/presentation/*
- lib/app.dart

### Changes Required
- Create WeatherEntity domain model
- Define WeatherRepository abstract contract
- Create data models representing OpenWeatherMap response structure
- Define remote data source class for weather fetch logic
- Define Geolocator-based location service under the data layer
- Implement repository concrete class that combines API + location results
- Prepare weather provider scaffold with state placeholders

### Deliverables
- Clean Architecture skeleton aligned with domain/data/presentation boundaries
- Reusable model and repository contracts
- Provider placeholder prepared for UI integration

### Acceptance Criteria
- No UI classes are imported into the domain layer
- Data layer handles remote API and GPS logic only
- Provider is the formal state owner for presentation logic

---

## Phase 3: API and Location Integration
Checkpoint: "feat: integrate weather api and location services"

### Objective
Implement the concrete external integrations: current location detection and OpenWeatherMap weather fetching.

### Affected Files
- lib/data/services/location_service.dart
- lib/data/datasources/weather_remote_data_source.dart
- lib/data/repositories/weather_repository_impl.dart
- lib/domain/repositories/weather_repository.dart
- lib/data/models/weather_model.dart
- lib/core/constants/app_constants.dart

### Changes Required
- Configure API base URL and endpoints for current weather and 5-day forecast
- Add API key handling via environment-safe constants or config file
- Implement weather fetch by city name
- Implement current weather fetch by GPS coordinates
- Implement forecast fetch for 5-day data
- Add language parameter handling for English and Arabic
- Implement location permission and error handling
- Map API responses into domain-ready models

### Deliverables
- Weather repository is functional and returns domain entities
- Current location fetch works when permission is granted
- City search fetch works for valid locations
- Error responses are unified and usable by UI state handling

### Acceptance Criteria
- Location permission denial is gracefully handled
- Network failures surface clear user-friendly errors
- API data is transformed without leaking data-layer details into UI code
- Forecast and current weather are available through repository interfaces

---

## Phase 4: State and UI MVP
Checkpoint: "feat: build weather dashboard mvp"

### Objective
Build the single-screen dashboard and connect it to Provider state management, loading, and error states.

### Affected Files
- lib/presentation/providers/weather_provider.dart
- lib/presentation/screens/weather_dashboard_screen.dart
- lib/presentation/widgets/
  - weather_card.dart
  - forecast_list.dart
  - error_banner.dart
  - loading_indicator.dart
- lib/app.dart
- lib/main.dart

### Changes Required
- Create `WeatherProvider` with state machine values such as:
  - initial
  - loading
  - loaded
  - error
- Add methods for:
  - loadCurrentLocationWeather()
  - searchCityWeather(String query)
  - retryLastRequest()
- Build a single-screen dashboard with:
  - search bar
  - current location action
  - current weather main card
  - multi-day forecast list
  - inline error banner/card
  - loading indicator
- Support responsive layout for mobile and web
- Implement a simple AR/EN toggle in the header and localize labels and API call language
- Ensure RTL/LTR alignment updates correctly when locale changes

### Deliverables
- Complete single-page MVP dashboard
- Provider-managed state transitions
- Inline retry/error support
- Safe UI rendering for mobile and web layouts

### Acceptance Criteria
- User can fetch current weather using GPS
- User can search for any valid city and get updated results
- Forecast is displayed without navigation
- Loading and error states are visible in-place
- Language toggling changes UI and API locale behavior

---

## Phase 5: QA, Finalization, and Regression Check
Checkpoint: "fix: finalize weather app mvp"

### Objective
Verify the app is stable, within scope, and ready for final review.

### Affected Files
- lib/*
- test/*
- README.md
- docs/*
- AGENTS.md

### Changes Required
- Run Flutter analysis and unit/widget tests
- Verify no scope creep has been introduced
- Validate the app on mobile/web responsive layouts
- Confirm state handling is explicit and retryable
- Validate AR/EN toggle and localized requests
- Update documentation to reflect final state
- Ensure Git checkpoints are aligned to actual milestones

### Deliverables
- Final verified MVP
- Review-ready project structure
- Documented acceptance evidence and final scope confirmation

### Acceptance Criteria
- No analyzer errors or critical warnings
- Core user flows work without navigation-related issues
- Search, location fetch, forecast display, and language toggle all work
- Git checkpoint sequence matches the final implementation
- Final scope remains within approved MVP boundaries

---

## 4. Rollback Note & Git Checkpoints Alignment

### Rollback Strategy
If any phase reveals a blocking issue or architecture violation, the safe rollback path is to revert the last milestone commit and restore the previous checkpoint state before continuing. This keeps the project reviewable, minimizes risk, and preserves the strict atomic SDLC workflow.

### Checkpoint Alignment
| Milestone | Required Git Action | Outcome |
| --- | --- | --- |
| Phase 1 | git status; git add .; git commit -m "chore: initialize weather app project" | Project baseline ready |
| Phase 2 | git status; git add lib; git commit -m "feat: add clean architecture foundation" | Domain/data/presentation skeleton ready |
| Phase 3 | git status; git add lib; git commit -m "feat: integrate weather api and location services" | API and location integration working |
| Phase 4 | git status; git add lib; git commit -m "feat: build weather dashboard mvp" | Single-screen provider-driven UI complete |
| Phase 5 | git status; git add .; git commit -m "fix: finalize weather app mvp" | QA polish and final verification complete |

### Manual Review Rule
Before each checkpoint, the developer must review the git diff to ensure the change remains disciplined, within scope, and free of unrelated refactoring.

---

## 5. Acceptance Criteria Mapping

| Requirement | Source | Milestone | Validation |
| --- | --- | --- | --- |
| Current location weather fetch | SPEC-001 FR-01 | Phase 3 / Phase 4 | User can fetch local weather by GPS |
| Manual city search | SPEC-001 FR-02 | Phase 3 / Phase 4 | Search updates dashboard with valid city data |
| Single dashboard screen | SPEC-001 FR-03 | Phase 4 | Current weather + forecast visible without navigation |
| 5-day forecast | SPEC-001 FR-04 | Phase 3 / Phase 4 | Forecast cards show upcoming data |
| Arabic/English support | SPEC-001 FR-05 | Phase 4 | Locale toggle and API language parameter work |
| Loading / success / error states | SPEC-001 FR-06 | Phase 4 | Inline state handling and retry are visible |
| Clean Architecture | AGENTS.md / SPEC-001 | Phase 2+ | Layers remain separated and reviewable |
| Provider state management | SPEC-001 technical architecture | Phase 2 / Phase 4 | UI state flows through provider only |
| 2-hour MVP scope compliance | AGENTS.md / SPEC-001 | All phases | No out-of-scope features introduced |

---

## 6. Final Implementation Note
The implementation should never exceed the approved MVP boundaries. The project should be considered complete only when the app is functionally small, architecture-compliant, and verifiably aligned with the specification and Git checkpoint workflow.
