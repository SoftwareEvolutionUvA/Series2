module Detector::Detector2

import lang::java::m3::AST;
import Set;

set[Declaration] generalize(set[Declaration] ast) {
    return visit(ast) {
        // Declaration
        case \enum(name, implements, constants, body) => \enum("genericEnum", implements, constants, body)
        case \enumConstant(name, arguments, class) => \enumConstant("genericConstant", arguments, class)
        case \enumConstant(name, arguments) => \enumConstant("genericConstant", arguments)
        case \class(name, extends, implements, body) => \class("genericClass", extends, implements, body)
        case \interface(name, extends, implements, body) => \interface("genericInterface", extends, implements, body)
        case \method(ret, name, parameters, exceptions, impl) => \method(ret, "genericMethod", parameters, exceptions, impl)
        case \constructor(name, parameters, exceptions, impl) => \constructor("genericConstructor", parameters, exceptions, impl)
        //case \typeParameter(name, extendsList) => \typeParameter("T", extendsList)
        case \annotationType(name, body) => \annotationType("genericAnnotationType", body)
        case \annotationTypeMember(typ, name) => \annotationTypeMember(typ, "genericAnnotationTypeMember")
        case \annotationTypeMember(typ, name, defaultBlock) => \annotationTypeMember(typ, "genericAnnotationTypeMember", defaultBlock)
        case \parameter(typ, name, extraDimensions) => \parameter(typ, "genericParameter", extraDimensions)
        case \vararg(typ, name) => \vararg(typ, "genericVarArg")

        // Expression
        case \assignment(lhs, operator, rhs) => \assignment(lhs, "=", rhs)
        case \characterLiteral(charValue) => \characterLiteral("a")
        case \fieldAccess(isSuper,expression, name) => \fieldAccess(isSuper,expression, "genericFieldAccess")
        case \fieldAccess(isSuper, name) => \fieldAccess(isSuper, "genericFieldAccess")
        case \methodCall(isSuper, name, arguments) => \methodCall(isSuper, "genericMethodCall", arguments)
        case \methodCall(isSuper, receiver, name, arguments) => \methodCall(isSuper, receiver, "genericMethodCall", arguments)
        case \number(numberValue) => \number("0")
        case \booleanLiteral(boolValue) => \booleanLiteral(true)
        case \stringLiteral(stringValue) => \stringLiteral("A")
        case \variable(name, extraDimensions) => \variable("genericVar", extraDimensions)
        case \variable(name, extraDimensions, \initializer) => \variable("genericVar", extraDimensions, \initializer)
        case \infix(lhs, operator, rhs) => \infix(lhs, "+", rhs)
        case \postfix(operand, operator) => \postfix(operand, "+")
        case \prefix(operator, operand) => \prefix("+", operand)
        case \simpleName(name) => \simpleName("simpleName")
        case \markerAnnotation(typeName) => \markerAnnotation("genericMarkerAnnotation")
        case \normalAnnotation(typeName, memberValuePairs) => \normalAnnotation("genericMarkerAnnotation", memberValuePairs)
        case \memberValuePair(name, \value) => \memberValuePair("genericMemberValuePair", \value)
        case \singleMemberAnnotation(typeName, \value) => \singleMemberAnnotation("genericMemberAnnotation", \value)

        // Statement
        case \break(label) => \break("genericBreak")
        case \label(name, body) => \label("genericLabel", body)
        case \continue(label) => \continue("genericContinue")

        // Type
        case \int() => Type::\int()
        case short() => Type::\int()
        case long() => Type::\int()
        case float() => Type::\int()
        case double() => Type::\int()
        case char() => Type::\int()
        case string() => Type::\int()
        case byte() => Type::\int()
        case \void() => Type::\int()
        case \boolean() => Type::\int()

        // Modifier
        case \private() => \friendly()
        case \public() => \friendly()
        case \protected() => \friendly()
        case \friendly() => \friendly()
    }
}