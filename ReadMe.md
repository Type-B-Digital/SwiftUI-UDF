# Clean Unidirectional Architecture in SwiftUI with ReSwift

## Problems with Current MVVM in SwiftUI

While MVVM is commonly used in SwiftUI, it tends to fall short as projects grow in complexity. Some of the key issues include:

### 1. **Tight Coupling Between ViewModel and Views**
- ViewModels often grow large and tightly coupled to the views they're serving.
- Reusability is reduced, and testing becomes harder.

### 2. **Scattered State Management**
- State updates can occur in multiple places (e.g., view, view model, combine pipelines).
- Difficult to track source of truth or reason about app state.

### 3. **Ad-hoc Side Effects**
- API calls and side effects are performed inside `@MainActor` ViewModels.
- No standard place to manage side effects like networking, analytics, etc.

### 4. **No Formal Action Tracking**
- Impossible to trace which action caused a state change.
- Harder to debug, test, or retry failed actions.

### 5. **Inconsistent Error Handling**
- Errors handled in random ways: closures, Combine, `do-catch`, etc.
- ViewModels cluttered with conditional error logic.

---

## Benefits of Unidirectional Architecture

Adopting a clean, unidirectional data flow solves these issues by separating concerns clearly. This project adopts a ReSwift-based architecture with structured layers:

### 1. **Single Source of Truth**
- `AppState` acts as the only source of truth.
- Views reactively reflect the state via `@Published` properties mapped from store updates.

### 2. **Pure Actions, Reducers, and State**
- All state changes happen via dispatched actions.
- Reducers are pure functions, making them predictable and testable.

### 3. **Tracked Actions with `actionId`s**
- Each dispatched action is uniquely tracked.
- Status (`INIT`, `COMPLETED`, `ERROR`) is managed centrally and observed in `BaseViewModel`.

### 4. **Centralized Side Effects via Middleware**
- All asynchronous or external side effects (e.g., API calls) handled in Redux middleware.
- Actions like `.request`, `.success`, `.failure` provide a predictable async flow.

### 5. **BaseViewModel for Reusability**
- All ViewModels extend `BaseViewModel`, which:
  - Subscribes to state.
  - Manages action lifecycle.
  - Tracks status and errors.
  - Prevents repetition and boilerplate code.

### 6. **Composable, Predictable Views**
- SwiftUI views become simple renderers of state.
- Business logic and mutations are handled outside the views.

---

## Architecture Overview

### Layers:

![layers](https://github.com/user-attachments/assets/82131ec4-c120-4161-ae34-c25a326ecda5)

### Flow:

1. View triggers `dispatchAction(FetchFollowers.request(...))`.
2. `BaseViewModel` adds `actionId` and dispatches a `TrackedAction`.
3. Middleware listens and triggers async operations (e.g., API calls).
4. Middleware dispatches `.perform`, `.success`, or `.failure` actions.
5. Reducers update the `AppState`.
6. `BaseViewModel` observes state updates and calls `onStateUpdate` or `onError`.
7. View reflects new state via `@Published` bindings.
   

![uni directional data flow](https://github.com/user-attachments/assets/bfd89d16-730b-4243-b16b-2d5fdbda8467)

---

## Benefits Recap

![ChatGPT Image Jun 5, 2025, 08_34_58 AM](https://github.com/user-attachments/assets/0739bef8-d92a-4d9f-8a99-a062eb43443f)

| Concern               | MVVM                          | Unidirectional Architecture     |
|----------------------|-------------------------------|---------------------------------|
| State Management      | Scattered                     | Centralized in AppState         |
| Side Effects          | In ViewModels                 | Middleware only                 |
| Action Tracking       | Not possible                  | Fully Tracked via `actionId`    |
| ViewModel Size        | Grows large                   | Modular, logic-free             |
| Debuggability         | Hard to trace bugs            | Fully traceable with actions    |
| Reusability           | Poor                          | High due to BaseViewModel       |
| Testing               | Complex due to state spread   | Easy due to pure functions      |

---

## Conclusion

This architecture brings **clarity**, **predictability**, **testability**, and **scalability** to SwiftUI app. It enforces best practices, ensures unidirectional flow, and enables production-grade app development with less friction.

## References 

- ReSwift : https://github.com/ReSwift/ReSwift?tab=readme-ov-file
- PromiseKit : https://github.com/mxcl/PromiseKit

Medium :

- https://medium.com/joshtastic-blog/redux-for-ios-apps-d581f0c58b34
- https://medium.com/@anshulrokde/redux-in-swift-beeb15b60517
- https://medium.com/p/fc62f1e0da9f - Sri Lankan large ride-hailing app: Latest technical experience
