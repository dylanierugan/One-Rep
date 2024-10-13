//
//  StringEnums.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation

enum ActivityViewStrings: String {
    case ID = "one-rep-hpeel"
    case MovementKey = "user_movements"
    case UserKey = "user_model"
}

enum AddMovementStrings: String {
    case NewMovement = "New Movement"
    case MovementName = "Movement name"
    case MovementType = "Movement type"
    case MuscleGroup = "Muscle group"
    case Add = "Add"
}

enum AddRoutineStrings: String {
    case NewRoutine = "New Routine"
    case RoutineName = "Routine name"
    case RoutineIcon = "Routine icon"
    case SelectMovements = "Select Movements"
}

enum AppConstants: String {
    case ID = "one-rep-hpeel"
    case MovementKey = "user_movements"
    case UserKey = "user_model"
}

enum AppleSignInManagerStrings: String {
    case CharSet = "0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._"
    case Format = "%02x"
}

enum BodyweightStrings: String {
    case Bodyweight = "Bodyweight"
    case SetBodyweight = "Set  bodyweight"
    case RemoveWeight = "Remove weight"
    case AddWeight = "Add weight"
    case Set = "Set"
    case EnterBodyweight = "Enter bodyweight"
    case Done = "Done"
}

enum ContactSupportStrings: String {
    case NotSetUp = "Body weight"
    case DylanRecipient = "dylan@dylfyt.com"
    case TarekRecipient = "tarekatonerep@gmail.com"
}

enum Colors: String {
    case BackgroundElementColor = "BackgroundElementColor"
    case BackgroundColor = "BackgroundColor"
    case DarkBlue = "DarkBlue"
    case DarkGreen = "DarkGreen"
    case DarkOrange = "DarkOrange"
    case DarkPink = "DarkPink"
    case DarkRed = "DarkRed"
    case DarkYellow = "DarkYellow"
    case LightBlue = "LightBlue"
    case LightGreen = "LightGreen"
    case LightOrange = "LightOrange"
    case LightPink = "LightPink"
    case LightRed = "LightRed"
    case LightYellow = "LightYellow"
    case Primary = "customPrimary"
    case ReversePrimary = "ReversePrimary"
    case SecondaryBackgroundColor = "SecondaryBackgroundColor"
}

enum DateStrings: String {
    case GoToToday = "Go to Today"
    case monthDayFormat = "MMMM d"
}

enum DefaultKeys: String {
    case AccentColor = "AccentColor"
}

enum DeleteAccountStrings: String {
    case DeleteAccount = "Delete Account"
    case DeleteAccountInstructions = "To delete your account, please reauthenticate. Once reauthentication is complete, your account and all associated data will be permanently deleted."
    case DeleteAccountConfirmation = "Are you sure you want to delete your account and all the data associated with it?"
    case NoWayToUndo = "There is no way to undo this action."
    case Delete = "Delete"
}

enum EditLogStrings: String {
    case EditLog = "Edit Log"
    case EditWeight = "Edit weight"
    case EditAddedWeight = "Edit added weight"
    case EditReps = "Edit reps"
    case DateTime = "Date/Time"
    case Done = "Done"
    case Update = "Update"
    case Delete = "Delete"
    case EditBodyweight = "Edit Bodyweight"
}

enum EditMovementStrings: String {
    case EditMovement = "Edit Movement"
    case EditName = "Edit name"
    case EditMovementType = "Edit movement type"
    case EditMuscleGroup = "Edit muscle group"
    case Update = "Update"
    case Delete = "Delete"
}

enum EditRoutineStrings: String {
    case EditRoutine = "Edit Routine"
    case EditName = "Edit name"
    case Update = "Update"
    case Delete = "Delete"
}

enum ErrorMessage: String {
    case DeleteMovmentConfirmation = "Are you sure you want to delete this movement and all the logged data associated with it?"
    case DeleteRoutineConfirmation = "Are you sure you want to delete this routine and all the logged data associated with it?"
    case ErrorAddMovement = "There was an error adding the movement."
    case ErrorGetMovements = "There was an error loading movements."
    case NoWayToUndo = "There is no way to undo this action."
}

enum FirebaseCollection: String {
    case MovementCollection = "movements"
    case LogsCollection = "logs"
    case RoutinesCollection = "routines"
    case UserCollection = "users"
    case BodyweightCollection = "bodyweightEntrties"
}

enum HelpSectionStrings: String {
    case Help = "Help"
    case ContactSupport = "Contact Support"
    case SupportMessage = "Please leave any questions, comments, or issues below"
}

enum Icons: String {
    case ArrowCounterclockwise = "arrow.counterclockwise"
    case ArrowshapeForwardFill = "arrowshape.forward.fill"
    case Atom = "atom"
    case Bench = "bench"
    case BookMarkFill = "bookmark.fill"
    case Calendar = "calendar"
    case ChartXYAxis = "chart.xyaxis.line"
    case Checkmark = "checkmark"
    case ChevronCompactDown = "chevron.compact.down"
    case ChevronCompactUp = "chevron.compact.up"
    case ChevronForward = "chevron.forward"
    case ChevronLeft = "chevron.left"
    case ChevronRight = "chevron.right"
    case ChevronCompactLeft = "chevron.compact.left"
    case ChevronCompactRight = "chevron.compact.right"
    case CircleFill = "circle.fill"
    case CircleHexagongrid = "circle.hexagongrid"
    case CrownFill = "crown.fill"
    case Dumbell = "dumbbell"
    case DumbellFill = "dumbbell.fill"
    case ErrorTriangle = "exclamationmark.triangle"
    case Eye = "eye"
    case EyeFill = "eye.fill"
    case EyeSlash = "eye.slash"
    case FigureArmsOpen = "figure.arms.open"
    case FigureCoreTraining = "figure.core.training"
    case FigureHighIntensityIntervaltraining = "figure.highintensity.intervaltraining"
    case FigureRower = "figure.rower"
    case FigureStrengthTraining = "figure.strengthtraining.traditional"
    case FigureStrengthTrainingFunctional = "figure.strengthtraining.functional"
    case Flame = "flame"
    case FlameFill = "flame.fill"
    case GearshapeFill = "gearshape.fill"
    case HeartFill = "heart.fill"
    case Infinity = "infinity"
    case InfoCircle = "info.circle"
    case MagnifyingGlass = "magnifyingglass"
    case Medal = "medal"
    case MedalFill = "medal.fill"
    case Minus = "minus"
    case MinusCircleFill = "minus.circle.fill"
    case NoteTextBadgePlus = "note.text.badge.plus"
    case ListBullet = "list.bullet.rectangle.portrait.fill"
    case LockFill = "lock.fill"
    case PaperPlaneFill = "paperplane.fill"
    case Pencil = "pencil"
    case PencilAndOutline = "pencil.and.outline"
    case PersonFill = "person.fill"
    case Plus = "plus"
    case PlusApp = "plus.app"
    case PlusAppFill = "plus.app.fill"
    case PlusCircle = "plus.circle"
    case PlusCircleFill = "plus.circle.fill"
    case RectangleAndPencilAndEllipsis = "rectangle.and.pencil.and.ellipsis"
    case RectanglePlus = "rectangle.stack.fill.badge.plus"
    case RectanglePortraitAndArrowRight = "rectangle.portrait.and.arrow.right"
    case SquareFill = "square.fill"
    case SquareAndPencil = "square.and.pencil"
    case TableCells = "tablecells"
    case TextBadgePlus = "text.badge.plus"
    case Trash = "trash"
    case TrashFill = "trash.fill"
    case TrashCircleFill = "trash.circle.fill"
    case TriangleFill = "triangle.fill"
    case XMarkCircleFill = "xmark.circle.fill"
}

enum InfoText: String {
    case CreateNewMovement = "Tap on the + button on the top right to create a new movement to track your sets"
    case DeleteAllDataConfirmation = "Are you sure you want to delete this movement and all the logged data associated with it?"
    case NoData = "No data\nLog some sets"
    case NoDataOnDay = "No data logged for this day"
    case NoWayToUndo = "There is no way to undo this action."
    case NoMovementForRoutines = "There are no movements to create a routine."
    case CreateNewRoutine = "Tap on the + button on the top right to create a new routine"
    case ChooseMovements = "Choose the movements you want to include in this routine"
    case RoutineNoMovements = "Tap on the + button in the top right to add movements to this routine"
}

enum KeyboardStrings: String {
    case Done = "Done"
}

enum LogAttributes: String {
    case UserId = "userId"
    case MovementId = "movementId"
    case Reps = "reps"
    case Weight = "weight"
    case Bodyweight = "bodyweight"
    case IsBodyWeight = "isBodyWeight"
    case TimeAdded = "timeAdded"
    case Unit = "unit"
}

enum LogCardStrings: String {
    case Set = "Set"
    case Reps = "reps"
}

enum LoginStrings: String {
    case DeleteMovmentConfirmation = "Do one more rep than last time"
}

enum LogoString: String {
    case OneRep = "1  Rep"
}

enum LogSetString: String {
    case Log = "Log"
}

enum LogOutStrings: String {
    case LogOut = "Log Out"
}

enum MovementSelection: String, Identifiable {
    var id: MovementSelection { self }
    case Activity = "Activity"
    case Routines = "Routines"
    case Library = "Library"
}

enum MovementsStrings: String {
    case Movements = "Movements"
    case Search = "Search"
}

enum MovementType: String, Identifiable, Codable {
    var id: MovementType { self }
    case Weight = "Weights"
    case Bodyweight = "Bodyweight"
}

enum MovementAttributes: String {
    case UserId = "userId"
    case Name = "name"
    case MuscleGroup = "muscleGroup"
    case MovementType = "movementType"
    case TimeAdded = "timeAdded"
    case IsPremium = "isPremium"
    case MutatingValue = "mutatingValue"
    case RoutineIds = "routineIds"
}

enum MuscleGroup: String, Identifiable, Codable, CaseIterable {
    var id: MuscleGroup { self }
    case All = "All"
    case Arms = "Arms"
    case Back = "Back"
    case Chest = "Chest"
    case Core = "Core"
    case Legs = "Legs"
    case Shoulders = "Shoulders"
}

enum MutateStrings: String {
    case Reps = "Reps"
    case Weight = "Weight"
}

enum NavigationTitleStrings: String {
    case Library = "Library"
    case Routines = "Routines"
    case Activity = "Activity"
}

enum PrivacyPolicy: String {
    case Text = "Privacy Policy"
    case Link = "https://one-rep.apphq.online/"
}

enum ProgressText: String {
    case OneRep = "One Rep"
    case Loading = "Loading..."
}

enum RepType: String, Identifiable, Codable, CaseIterable {
    var id: RepType { self }
    case WarmUp = "Warm Up"
    case WorkingSet = "Working Set"
    case PR = "PR"
}

enum RevenueCat: String {
    case PublicAPIKey = "appl_dEAoEEQiwepqzIsKKqoKNPYZAKA"
}

enum RoutineAttributes: String {
    case UserId = "userId"
    case Name = "name"
    case Icon = "icon"
    case MovementIds = "movementIDs"
}

enum RoutineStrings: String {
    case Routines = "Routines"
    case MovementsToAdd = "Movements to add"
}

enum SettingsStrings: String {
    case Settings = "Settings"
    case Account = "Account"
    case NoUser = "No user"
    case Units = "Units"
    case Theme = "Accent Color"
    case Appearance = "Appearance"
    case Light = "Light"
    case Dark = "Dark"
    case Anonymous = "Anonymous Email"
    case Subscription = "Subscription"
    case Subscribe = "Subscribe"
    case OneRepPremium = "One Rep Premium"
}

enum ToggleEditStrings: String {
    case Done = "Done"
    case Edit = "Edit"
}

enum Weekdays: String, Identifiable, Codable, CaseIterable {
    var id: Weekdays { self }
    case Sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
}

enum UnitSelection: String, Identifiable, Codable, CaseIterable {
    var id: UnitSelection { self }
    case lbs = "lbs"
    case kgs = "kgs"
    case lb = "lb"
    case kg = "kg"
}

enum ViewState {
    case loading
    case view
}

enum WeightSelection: String {
    case All = "All"
    case NoWeight = "No weight"
    case Zero = "0"
}

extension UserDefaults {
    private enum Keys {
        static let unitSelection = "unitSelection"
    }
    
    var unitSelection: UnitSelection {
        get {
            guard let savedValue = string(forKey: Keys.unitSelection),
                  let unit = UnitSelection(rawValue: savedValue) else {
                return .lbs
            }
            return unit
        }
        set {
            set(newValue.rawValue, forKey: Keys.unitSelection)
        }
    }
}

enum AppColorScheme: String, Identifiable, Codable, CaseIterable {
    var id: AppColorScheme { self }
    case light
    case dark
    case system
}

extension UserDefaults {
    private enum ColorSchemeKeys {
        static let colorScheme = "colorScheme"
    }
    
    var appColorScheme: AppColorScheme {
        get {
            guard let savedValue = string(forKey: ColorSchemeKeys.colorScheme),
                  let scheme = AppColorScheme(rawValue: savedValue) else {
                return .system // Default value
            }
            return scheme
        }
        set {
            set(newValue.rawValue, forKey: ColorSchemeKeys.colorScheme)
        }
    }
}
