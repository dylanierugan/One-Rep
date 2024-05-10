//
//  StringEnums.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation
import RealmSwift

enum DefaultKeys: CustomStringConvertible {
    case AccentColor
    
    var description : String {
        switch self {
        case .AccentColor: return "AccentColor"
        }
    }
}

enum ErrorMessage: CustomStringConvertible {
    case DeleteMovmentConfirmation
    case NoWayToUndo
    
    var description : String {
        switch self {
        case .DeleteMovmentConfirmation: return "Are you sure you want to delete this movement and all the logged data associated with it?"
        case .NoWayToUndo: return "There is no way to undo this action."
        }
    }
}

enum Colors: CustomStringConvertible {
    case BackgroundElementColor
    case BackgroundColor
    case DarkBlue
    case DarkGreen
    case DarkOrange
    case DarkPink
    case DarkRed
    case DarkYellow
    case LightBlue
    case LightGreen
    case LightOrange
    case LightPink
    case LightRed
    case LightYellow
    case ReversePrimary
    case SecondaryBackgroundColor
    
    var description : String {
        switch self {
        case .BackgroundElementColor: return "BackgroundElementColor"
        case .BackgroundColor: return "BackgroundColor"
        case .DarkBlue: return "DarkBlue"
        case .DarkGreen: return "DarkGreen"
        case .DarkOrange: return "DarkOrange"
        case .DarkPink: return "DarkPink"
        case .DarkRed: return "DarkRed"
        case .DarkYellow: return "DarkYellow"
        case .LightBlue: return "LightBlue"
        case .LightGreen: return "LightGreen"
        case .LightOrange: return "LightOrange"
        case .LightPink: return "LightPink"
        case .LightRed: return "LightRed"
        case .LightYellow: return "LightYellow"
        case .ReversePrimary: return "ReversePrimary"
        case .SecondaryBackgroundColor: return "SecondaryBackgroundColor"
        }
    }
}

enum Icons: CustomStringConvertible {
    case ArrowCounterclockwise
    case ArrowshapeForwardFill
    case Atom
    case Bench
    case BookMarkFill
    case Calendar
    case ChartXYAxis
    case ChevronForward
    case CircleFill
    case CircleHexagongrid
    case Dumbell
    case DumbellFill
    case ErrorTriangle
    case Eye
    case EyeFill
    case EyeSlash
    case FigureCoreTraining
    case FigureHighIntensityIntervaltraining
    case FigureStrengthTraining
    case FigureStrengthTrainingFunctional
    case FigureRower
    case Flame
    case FlameFill
    case HeartFill
    case Infinity
    case InfoCircle
    case Medal
    case MedalFill
    case Minus
    case MinusCircleFill
    case NoteTextBadgePlus
    case ListBullet
    case LockFill
    case PaperPlaneFill
    case Pencil
    case PencilAndOutline
    case PersonFill
    case Plus
    case PlusAppFill
    case PlusCircle
    case PlusCircleFill
    case RectangleAndPencilAndEllipsis
    case RectanglePlus
    case GearshapeFill
    case SquareFill
    case SquareAndPencil
    case TableCells
    case TextBadgePlus
    case Trash
    case TriangleFill
    
    var description : String {
        switch self {
        case .ArrowCounterclockwise: return "arrow.counterclockwise"
        case .ArrowshapeForwardFill: return "arrowshape.forward.fill"
        case .Atom: return "atom"
        case .Bench: return "bench"
        case .BookMarkFill: return "bookmark.fill"
        case .Calendar: return "calendar"
        case .ChartXYAxis: return "chart.xyaxis.line"
        case .ChevronForward: return "chevron.forward"
        case .CircleFill: return "circle.fill"
        case .CircleHexagongrid: return "circle.hexagongrid"
        case .Dumbell: return "dumbbell"
        case .DumbellFill: return "dumbbell.fill"
        case .ErrorTriangle: return "exclamationmark.triangle"
        case .Eye: return "eye"
        case .EyeFill: return "eye.fill"
        case .EyeSlash: return "eye.slash"
        case .FigureCoreTraining: return "figure.core.training"
        case .FigureHighIntensityIntervaltraining: return "figure.highintensity.intervaltraining"
        case .FigureStrengthTraining: return "figure.strengthtraining.traditional"
        case .FigureStrengthTrainingFunctional: return "figure.strengthtraining.functional"
        case .Flame: return "flame"
        case .FlameFill: return "flame.fill"
        case .FigureRower: return "figure.rower"
        case .HeartFill: return "heart.fill"
        case .Infinity: return "infinity"
        case .InfoCircle: return "info.circle"
        case .Minus: return "minus"
        case .MinusCircleFill: return "minus.circle.fill"
        case .Medal: return "medal"
        case .MedalFill: return "medal.fill"
        case .NoteTextBadgePlus: return "note.text.badge.plus"
        case .ListBullet: return "list.bullet.rectangle.portrait.fill"
        case .LockFill: return "lock.fill"
        case .PaperPlaneFill: return "paperplane.fill"
        case .Pencil: return "pencil"
        case .PencilAndOutline: return "pencil.and.outline"
        case .PersonFill: return "person.fill"
        case .Plus: return "plus"
        case .PlusAppFill: return "plus.app.fill"
        case .PlusCircle: return "plus.circle"
        case .PlusCircleFill: return "plus.circle.fill"
        case .RectangleAndPencilAndEllipsis: return "rectangle.and.pencil.and.ellipsis"
        case .RectanglePlus: return "rectangle.stack.fill.badge.plus"
        case .GearshapeFill: return "gearshape.fill"
        case .SquareFill: return "square.fill"
        case .SquareAndPencil: return "square.and.pencil"
        case .TableCells: return "tablecells"
        case .TextBadgePlus: return "text.badge.plus"
        case .Trash: return "trash"
        case .TriangleFill: return "triangle.fill"
        }
    }
    
    enum UserDefault: CustomStringConvertible {
        case AccentColor
        case DarkMode
        
        var description : String {
            switch self {
            case .AccentColor: return "accentColor"
            case .DarkMode: return "darkMode"
            }
        }
    }
}

enum InfoText: CustomStringConvertible {
    case CreateNewMovement
    case NoData
    
    var description: String {
        switch self {
            case .CreateNewMovement: return "Click on the  +  to create a new movement to track your sets"
            case .NoData: return "No data"
        }
    }
}

enum MuscleType: String, PersistableEnum, Identifiable {
    var id: MuscleType { self }
    case All = "All"
    case Arms = "Arms"
    case Back = "Back"
    case Chest = "Chest"
    case Core = "Core"
    case Legs = "Legs"
    case Shoulders = "Shoulders"
}

enum RepType: String, PersistableEnum {
  case WarmUp = "Warm Up"
  case WorkingSet = "Working Set"
  case PR = "PR"
}
