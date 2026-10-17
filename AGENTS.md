# AGENTS.md

## Purpose
This repository follows a strict AI SDLC workflow to keep delivery disciplined, reviewable, and aligned with the approved project scope. This file defines atomic execution rules, quality gates, and required manual Git checkpoints.

## Mandatory Workflow Rules

### 1. One Task at a Time
- Work in small, atomic units of change.
- Do not combine unrelated features into one patch.
- Each task must have a single, clear objective.

### 2. Validate Before Completion
- Run the relevant tests, build checks, or static analysis after each atomic change.
- If a feature is not verifiable, it is not complete.

### 3. Follow Clean Architecture Boundaries
- Domain logic must not depend on UI or framework types.
- Data-layer code must not leak implementation details into the UI.
- Presentation logic must remain focused on state and rendering.

### 4. Keep the MVP Strict
- Do not expand scope beyond the approved MVP.
- Avoid adding features that are out of scope unless explicitly approved.
- If a requested improvement conflicts with the 2-hour timeline, defer it.

### 5. Prefer Small, Reviewable Changes
- Keep patch size focused and understandable.
- Write code that is easy to inspect in a single review session.
- Avoid hidden or unnecessary refactors during feature work.

### 6. State Handling Must Be Explicit
- Loading, success, and error states must be visible and intentional.
- Errors must be user-friendly and actionable.
- Retry or recovery actions must be supported where applicable.

## Required Manual Git Checkpoints
Git commits must be made manually by the developer after each major milestone. Do not rely on automatic commit generation for final checkpoints.

### Checkpoint 1: Project Initialization
After creating the baseline Flutter project structure and required project files:
- git status
- git add .
- git commit -m "chore: initialize weather app project"

### Checkpoint 2: Architecture Foundation
After creating the domain and data layer skeleton:
- git status
- git add lib
- git commit -m "feat: add clean architecture foundation"

### Checkpoint 3: API and Location Integration
After implementing the OpenWeatherMap and Geolocator integration layer:
- git status
- git add lib
- git commit -m "feat: integrate weather api and location services"

### Checkpoint 4: State and UI MVP
After implementing the Provider-driven single-screen dashboard and UI state handling:
- git status
- git add lib
- git commit -m "feat: build weather dashboard mvp"

### Checkpoint 5: QA / Finalization
After verification, polish, and final tests:
- git status
- git add .
- git commit -m "fix: finalize weather app mvp"

## Commit Rules
- Every commit must represent a meaningful milestone.
- Avoid committing broken or half-finished work unless it is explicitly documented.
- Commit messages should use conventional prefixes such as: chore, feat, fix, docs, refactor.
- Manual review of git diff is required before each checkpoint.

## Quality Gates
Before signing off a task, confirm:
- Scope is still within MVP
- Code matches the architecture constraints
- Tests or checks have been run successfully
- Documentation reflects the current product state
- Git checkpoint was completed manually

## Prohibited Behaviors
- Mixing architecture, UI, and API work in one unreviewable patch
- Expanding the feature list beyond the approved scope
- Omitting state handling and retry flows
- Skipping final validation or manual commit checkpoints

## Final Rule
The project must remain intentionally small, disciplined, and traceable. Delivery quality is prioritized over feature breadth.
