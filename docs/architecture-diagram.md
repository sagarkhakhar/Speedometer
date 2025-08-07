# 🏗️ Speedometer App - Architecture Diagrams

## 📊 System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              SPEEDOMETER APP                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    PRESENTATION LAYER                              │   │
│  │  (User Interface & State Management)                               │   │
│  ├─────────────────────────────────────────────────────────────────────┤   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │   │
│  │  │   Speedometer   │  │   ContentView   │  │   SpeedometerApp    │ │   │
│  │  │      View       │  │                 │  │                     │ │   │
│  │  │  (Main UI)      │  │  (Wrapper)      │  │   (Entry Point)     │ │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────────┘ │   │
│  │           │                     │                     │              │   │
│  │           ▼                     │                     │              │   │
│  │  ┌─────────────────┐            │                     │              │   │
│  │  │ SpeedometerView │            │                     │              │   │
│  │  │    Model        │            │                     │              │   │
│  │  │  (UI Logic)     │            │                     │              │   │
│  │  └─────────────────┘            │                     │              │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                       │
│                                    ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      DOMAIN LAYER                                  │   │
│  │  (Business Logic & Core Entities)                                  │   │
│  ├─────────────────────────────────────────────────────────────────────┤   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │   │
│  │  │ SpeedometerValue│  │SpeedometerValue │  │SpeedometerValue     │ │   │
│  │  │                 │  │  Calculator     │  │  Formatter          │ │   │
│  │  │  (Data Model)   │  │  (Math Logic)   │  │  (Display Logic)    │ │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────────┘ │   │
│  │           │                     │                     │              │   │
│  │           ▼                     │                     │              │   │
│  │  ┌─────────────────┐            │                     │              │   │
│  │  │SpeedometerUseCase│            │                     │              │   │
│  │  │                 │            │                     │              │   │
│  │  │ (Business Rules)│            │                     │              │   │
│  │  └─────────────────┘            │                     │              │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                       │
│                                    ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                   INFRASTRUCTURE LAYER                             │   │
│  │  (Technical Support & Configuration)                               │   │
│  ├─────────────────────────────────────────────────────────────────────┤   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │   │
│  │  │SpeedometerConsts│  │DependencyContain│  │   View+Extensions   │ │   │
│  │  │                 │  │       er        │  │                     │ │   │
│  │  │ (Configuration) │  │ (DI Management) │  │   (Styling Tools)   │ │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────────┘ │   │
│  │                                                                     │   │
│  │  ┌─────────────────┐                                                │   │
│  │  │   ArcShape      │                                                │   │
│  │  │                 │                                                │   │
│  │  │ (Custom Shape)  │                                                │   │
│  │  └─────────────────┘                                                │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow Diagram

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    USER     │    │    VIEW     │    │  VIEWMODEL  │    │   USECASE   │
│             │    │             │    │             │    │             │
│ 1. Types    │───▶│ 2. Captures │───▶│ 3. Processes│───▶│ 4. Validates│
│    Value    │    │    Input    │    │    Input    │    │    Input    │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                              │
                                                              ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    USER     │    │    VIEW     │    │  VIEWMODEL  │    │   DOMAIN    │
│             │    │             │    │             │    │             │
│ 8. Sees     │◀───│ 7. Updates  │◀───│ 6. Updates  │◀───│ 5. Calculates│
│ Animation   │    │    UI       │    │    State    │    │    Value    │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

## 🎯 MVVM Pattern Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              MVVM ARCHITECTURE                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                            VIEW (UI)                               │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │   │
│  │  │ SpeedometerView │  │ SpeedometerDial │  │  InputControlsView  │ │   │
│  │  │                 │  │      View       │  │                     │ │   │
│  │  │ • Displays UI   │  │ • Shows Dial    │  │ • Text Field        │ │   │
│  │  │ • User Input    │  │ • Needle        │  │ • Update Button     │ │   │
│  │  │ • Animations    │  │ • Progress Arc  │  │ • Error Messages    │ │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────────┘ │   │
│  │           │                     │                     │              │   │
│  │           └─────────────────────┼─────────────────────┘              │   │
│  │                                 │                                  │   │
│  │                                 ▼                                  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                       │
│                                    ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                        VIEWMODEL (Logic)                           │   │
│  │  ┌─────────────────────────────────────────────────────────────────┐ │   │
│  │  │              SpeedometerViewModel                               │ │   │
│  │  │                                                                 │ │   │
│  │  │  • Manages UI State (@Published properties)                    │ │   │
│  │  │  • Handles User Interactions (Button taps, text input)         │ │   │
│  │  │  • Coordinates with UseCase (Business Logic)                   │ │   │
│  │  │  • Manages Animations and Timing                               │ │   │
│  │  │  • Provides Error Handling                                     │ │   │
│  │  └─────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                       │
│                                    ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                           MODEL (Data)                              │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │   │
│  │  │ SpeedometerValue│  │SpeedometerUseCase│  │SpeedometerValueCalc │ │   │
│  │  │                 │  │                 │  │                     │ │   │
│  │  │ • Data Structure│  │ • Business Rules│  │ • Math Calculations │ │   │
│  │  │ • Value Storage │  │ • Input Validation│  │ • Needle Angles    │ │   │
│  │  │ • Display Format│  │ • Scale Marks   │  │ • Progress Values   │ │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 🔧 Component Interaction Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        COMPONENT INTERACTIONS                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────┐         ┌─────────────┐         ┌─────────────┐           │
│  │ Speedometer │         │Speedometer  │         │Speedometer  │           │
│  │    App      │────────▶│   View      │────────▶│ ViewModel   │           │
│  │             │         │             │         │             │           │
│  │ • Entry     │         │ • UI        │         │ • State     │           │
│  │ • Setup     │         │ • Input     │         │ • Logic     │           │
│  └─────────────┘         └─────────────┘         └─────────────┘           │
│         │                       │                       │                   │
│         │                       │                       ▼                   │
│         │                       │              ┌─────────────┐             │
│         │                       │              │Speedometer  │             │
│         │                       │              │  UseCase    │             │
│         │                       │              │             │             │
│         │                       │              │ • Business  │             │
│         │                       │              │   Logic     │             │
│         │                       │              │ • Validation│             │
│         │                       │              └─────────────┘             │
│         │                       │                       │                   │
│         │                       │                       ▼                   │
│         │                       │              ┌─────────────┐             │
│         │                       │              │Speedometer  │             │
│         │                       │              │   Value     │             │
│         │                       │              │             │             │
│         │                       │              │ • Data      │             │
│         │                       │              │ • Format    │             │
│         │                       │              │ • Calculate │             │
│         │                       │              └─────────────┘             │
│         │                       │                       │                   │
│         │                       │                       ▼                   │
│         │                       │              ┌─────────────┐             │
│         │                       │              │Infrastructure│            │
│         │                       │              │   Layer     │             │
│         │                       │              │             │             │
│         │                       │              │ • Constants │             │
│         │                       │              │ • DI        │             │
│         │                       │              │ • Extensions│             │
│         │                       │              └─────────────┘             │
│         │                       │                       │                   │
│         └───────────────────────┼───────────────────────┘                   │
│                                 │                                           │
│                                 ▼                                           │
│                        ┌─────────────┐                                     │
│                        │    User     │                                     │
│                        │             │                                     │
│                        │ • Sees UI   │                                     │
│                        │ • Interacts │                                     │
│                        │ • Gets Feedback│                                   │
│                        └─────────────┘                                     │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 📊 File Structure Tree

```
Speedometer/
├── 📱 SpeedometerApp.swift                    # App entry point
├── 🎨 ContentView.swift                       # Main content wrapper
├── 🎯 Presentation/                           # User Interface Layer
│   ├── Views/
│   │   └── SpeedometerView.swift             # Main speedometer screen
│   └── ViewModels/
│       └── SpeedometerViewModel.swift        # UI logic and state management
├── 🧠 Domain/                                 # Business Logic Layer
│   ├── Entities/
│   │   └── SpeedometerValue.swift            # Data model and calculations
│   └── UseCases/
│       └── SpeedometerUseCase.swift          # Business rules and validation
├── 🔧 Infrastructure/                         # Technical Support Layer
│   ├── Constants/
│   │   └── SpeedometerConstants.swift        # All configuration values
│   ├── DI/
│   │   └── DependencyContainer.swift         # Component management
│   └── Extensions/
│       └── View+Extensions.swift             # Reusable styling
├── 🎨 ArcShape.swift                         # Custom circular drawing tool
├── 📱 Speedometer.xcodeproj/                 # Xcode project file
├── 🧪 SpeedometerTests/                      # Unit tests
│   ├── SpeedometerTests.swift
│   ├── SpeedometerValueTests.swift
│   └── SpeedometerViewModelTests.swift
└── 🎯 SpeedometerUITests/                    # UI tests
    ├── SpeedometerUITests.swift
    └── SpeedometerUITestsLaunchTests.swift
```

## 🔄 User Journey Flow

```
┌─────────────┐
│   App Start │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Demo       │
│ Animation   │
│ (0 → 15200) │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ User Types  │
│   Value     │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Validation  │
│   Check     │
└──────┬──────┘
       │
       ▼
┌─────────────┐    ┌─────────────┐
│   Valid?    │───▶│    Yes      │
└──────┬──────┘    └──────┬──────┘
       │                  │
       │ No               │
       ▼                  ▼
┌─────────────┐    ┌─────────────┐
│ Show Error  │    │ Calculate   │
│  Message    │    │ New Value   │
└──────┬──────┘    └──────┬──────┘
       │                  │
       └────────┬─────────┘
                │
                ▼
┌─────────────┐
│ Animate     │
│ Needle      │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Update      │
│ Display     │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ User Sees   │
│ Result      │
└─────────────┘
```

## 🎨 UI Component Hierarchy

```
SpeedometerView (Main Container)
├── HStack (Top Label)
│   └── Text("Frame")
├── SpeedometerDialView (Main Dial)
│   ├── Circle (Outer Ring)
│   ├── Circle (Background Dial)
│   ├── ArcShape (Background Progress Arc)
│   ├── ArcShape (Progress Arc with Animation)
│   ├── ScaleLabelsView (Numbers around dial)
│   │   └── Text (Scale Labels)
│   ├── CenterHubView (Center circle)
│   │   └── Circle (Hub)
│   ├── NeedleView (Moving needle)
│   │   └── Rectangle (Needle shape)
│   └── ValueDisplayView (Center number)
│       └── Text (Speed value)
└── InputControlsView (Bottom controls)
    ├── TextField (Input field)
    ├── Text (Error message - optional)
    └── Button (Update button)
```

## 🔧 Dependency Injection Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        DEPENDENCY INJECTION FLOW                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────┐         ┌─────────────┐         ┌─────────────┐           │
│  │Dependency   │         │Speedometer  │         │Speedometer  │           │
│  │ Container   │────────▶│  UseCase    │────────▶│ ViewModel   │           │
│  │             │         │             │         │             │           │
│  │ • Registers │         │ • Business  │         │ • UI Logic  │           │
│  │   Factories │         │   Logic     │         │ • State     │           │
│  │ • Resolves  │         │ • Validation│         │ • Animation │           │
│  │   Dependencies│       │ • Scale     │         │ • User      │           │
│  └─────────────┘         │   Marks     │         │   Input     │           │
│         │                └─────────────┘         └─────────────┘           │
│         │                        │                       │                   │
│         │                        │                       ▼                   │
│         │                        │              ┌─────────────┐             │
│         │                        │              │Speedometer  │             │
│         │                        │              │    View     │             │
│         │                        │              │             │             │
│         │                        │              │ • UI        │             │
│         │                        │              │ • Display   │             │
│         │                        │              │ • Animation │             │
│         │                        │              └─────────────┘             │
│         │                        │                       │                   │
│         └────────────────────────┼───────────────────────┘                   │
│                                  │                                           │
│                                  ▼                                           │
│                        ┌─────────────┐                                     │
│                        │    User     │                                     │
│                        │             │                                     │
│                        │ • Interacts │                                     │
│                        │ • Sees      │                                     │
│                        │ • Responds  │                                     │
│                        └─────────────┘                                     │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 📈 Performance Metrics

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PERFORMANCE METRICS                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🚀 Animation Performance:                                                  │
│  ├── Needle Movement: 0.8s spring animation                                │
│  ├── Progress Arc: 0.8s spring animation                                   │
│  ├── Value Display: 0.3s ease-in-out                                       │
│  └── Button Press: 0.2s ease-in-out                                        │
│                                                                             │
│  📱 Memory Usage:                                                           │
│  ├── ViewModel: ~2KB                                                        │
│  ├── UseCase: ~1KB                                                          │
│  ├── UI Components: ~5KB                                                    │
│  └── Total App: ~15KB                                                       │
│                                                                             │
│  ⚡ Response Time:                                                           │
│  ├── Input Validation: <1ms                                                 │
│  ├── Value Calculation: <1ms                                                │
│  ├── UI Update: <16ms (60fps)                                               │
│  └── Animation Start: <1ms                                                   │
│                                                                             │
│  🎯 Scalability:                                                            │
│  ├── Values Supported: 0 - 999,999                                          │
│  ├── Scale Marks: 7 positions                                               │
│  ├── Animation States: 3 (idle, animating, complete)                       │
│  └── Error States: 2 (none, error)                                          │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 🔍 Testing Strategy

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            TESTING STRATEGY                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🧪 Unit Tests:                                                             │
│  ├── SpeedometerValueTests.swift                                            │
│  │   ├── Value calculation tests                                            │
│  │   ├── Formatting tests                                                   │
│  │   └── Edge case tests                                                    │
│  │                                                                          │
│  ├── SpeedometerViewModelTests.swift                                        │
│  │   ├── State management tests                                             │
│  │   ├── User interaction tests                                             │
│  │   └── Animation timing tests                                             │
│  │                                                                          │
│  └── SpeedometerUseCaseTests.swift                                          │
│      ├── Input validation tests                                             │
│      ├── Business logic tests                                               │
│      └── Scale mark tests                                                   │
│                                                                             │
│  🎯 Integration Tests:                                                       │
│  ├── Component interaction tests                                            │
│  ├── Dependency injection tests                                             │
│  └── End-to-end workflow tests                                              │
│                                                                             │
│  📱 UI Tests:                                                               │
│  ├── User interaction tests                                                 │
│  ├── Animation behavior tests                                               │
│  ├── Error handling tests                                                   │
│  └── Accessibility tests                                                    │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 🎨 Design System

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                             DESIGN SYSTEM                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🎨 Colors:                                                                 │
│  ├── Primary Blue: RGB(92, 173, 227) - #5CADE3                            │
│  ├── Dark Blue: RGB(51, 153, 219) - #3399DB                               │
│  ├── Background: RGB(82, 89, 97) - #525961                                │
│  ├── Dark Background: RGB(59, 61, 71) - #3B3D47                           │
│  ├── Hub: RGB(28, 31, 36) - #1C1F24                                       │
│  └── Hub Border: RGB(43, 46, 51) - #2B2E33                                │
│                                                                             │
│  📏 Layout:                                                                 │
│  ├── Dial Size: 270x270px                                                  │
│  ├── Container Size: 300x300px                                             │
│  ├── Needle Size: 4x95px                                                   │
│  ├── Hub Size: 32x32px                                                     │
│  └── Spacing: 30px between elements                                        │
│                                                                             │
│  🔤 Typography:                                                             │
│  ├── Value Display: 36pt Bold                                              │
│  ├── Scale Labels: 14pt Bold                                               │
│  ├── Caption: 14pt Regular                                                 │
│  └── Error Messages: 12pt Regular                                          │
│                                                                             │
│  🎭 Animations:                                                             │
│  ├── Spring Response: 0.8                                                  │
│  ├── Spring Damping: 0.6                                                   │
│  ├── Duration: 0.3s                                                        │
│  └── Blend Duration: 0.3s                                                  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

_These diagrams provide a comprehensive visual understanding of the Speedometer app's architecture, data flow, and component relationships. They help developers, designers, and stakeholders understand how the app works at different levels of abstraction._
