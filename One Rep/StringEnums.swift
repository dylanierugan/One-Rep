//
//  StringEnums.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation

enum Colors: CustomStringConvertible {
    case AlertRed
    case BackgroundColor
    case Green
    case LightGreen
    case Yellow
    case White
    
    var description : String {
        switch self {
        case .AlertRed: return "alertRed"
        case .BackgroundColor: return "BackgroundColor"
        case .Green: return "Green"
        case .LightGreen: return "LightGreen"
        case .Yellow: return "Yellow"
        case .White: return "White"
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
    case HeartFill
    case Infinity
    case InfoCircle
    case MinusCircleFill
    case NoteTextBadgePlus
    case ListBullet
    case LockFill
    case PaperPlaneFill
    case PencilAndOutline
    case PersonFill
    case PlusApp
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
        case .DumbellFill: return "dumbbell.fill"
        case .ErrorTriangle: return "exclamationmark.triangle"
        case .Eye: return "eye"
        case .EyeFill: return "eye.fill"
        case .EyeSlash: return "eye.slash"
        case .FigureCoreTraining: return "figure.core.training"
        case .FigureHighIntensityIntervaltraining: return "figure.highintensity.intervaltraining"
        case .FigureStrengthTraining: return "figure.strengthtraining.traditional"
        case .FigureStrengthTrainingFunctional: return "figure.strengthtraining.functional"
        case .FigureRower: return "figure.rower"
        case .HeartFill: return "heart.fill"
        case .Infinity: return "infinity"
        case .InfoCircle: return "info.circle"
        case .MinusCircleFill: return "minus.circle.fill"
        case .NoteTextBadgePlus: return "note.text.badge.plus"
        case .ListBullet: return "list.bullet.rectangle.portrait.fill"
        case .LockFill: return "lock.fill"
        case .PaperPlaneFill: return "paperplane.fill"
        case .PencilAndOutline: return "pencil.and.outline"
        case .PersonFill: return "person.fill"
        case .PlusApp: return "plus.app"
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
