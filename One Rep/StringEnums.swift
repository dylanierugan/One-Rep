//
//  StringEnums.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation

enum AppConstants: String {
    case ID = "one-rep-hpeel"
    case MovementKey = "user_movements"
    case UserKey = "user_model"
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
    case Primary = "Primary"
    case ReversePrimary = "ReversePrimary"
    case SecondaryBackgroundColor = "SecondaryBackgroundColor"
}

enum DefaultKeys: String {
    case AccentColor = "AccentColor"
}

enum ErrorMessage: String {
    case DeleteMovmentConfirmation = "Are you sure you want to delete this movement and all the logged data associated with it?"
    case ErrorAddMovement = "There was an error adding the movement."
    case ErrorGetMovements = "There was an error loading movements."
    case NoWayToUndo = "There is no way to undo this action."
}

enum FirebaseCollection: String {
    case MovementCollection = "Movements"
    case LogsCollection = "Logs"
}

enum FirebaseResult {
    case success
    case failure(Error)
}

enum Icons: String {
    case ArrowCounterclockwise = "arrow.counterclockwise"
    case ArrowshapeForwardFill = "arrowshape.forward.fill"
    case Atom = "atom"
    case Bench = "bench"
    case BookMarkFill = "bookmark.fill"
    case Calendar = "calendar"
    case ChartXYAxis = "chart.xyaxis.line"
    case ChevronCompactDown = "chevron.compact.down"
    case ChevronCompactUp = "chevron.compact.up"
    case ChevronForward = "chevron.forward"
    case ChevronLeft = "chevron.left"
    case ChevronRight = "chevron.right"
    case ChevronCompactLeft = "chevron.compact.left"
    case ChevronCompactRight = "chevron.compact.right"
    case CircleFill = "circle.fill"
    case CircleHexagongrid = "circle.hexagongrid"
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
    case TrashCircleFill = "trash.circle.fill"
    case TriangleFill = "triangle.fill"
}

enum InfoText: String {
    case CreateNewMovement = "Click on the + to create a new movement to track your sets"
    case DeleteAllDataConfirmation = "Are you sure you want to delete this movement and all the logged data associated with it?"
    case NoData = "No data\nLog some sets"
    case NoDataOnDay = "No data logged for this day"
    case NoWayToUndo = "There is no way to undo this action."
}

enum MovementSelection: String, Identifiable {
    var id: MovementSelection { self }
    case Activity = "Activity"
    case Routines = "Routines"
    case Library = "Library"
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

enum Weekdays: String {
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
}

enum WeightSelection: String {
    case all = "All"
}
