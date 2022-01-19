type t =
  | Cast0
  | BitCast
  | Cast2
  | Cast3
  | LValueToRValue
  | NoOp
  | Cast6
  | Cast7
  | Cast8
  | Cast9
  | Cast10
  | ArrayToPointerDecay
  | FunctionToPointerDecay
  | NullToPointer
  | Cast14
  | Cast15
  | Cast16
  | Cast17
  | Cast18
  | Cast19
  | Cast20
  | IntegerToPointer
  | Cast22
  | Cast23
  | ToVoid
  | Cast25
  | IntegralCast
  | IntegralToBoolean
  | IntegralToFloating
  | FloatingToFixedPoint
  | FixedPointToFloating
  | FixedPointCast
  | FixedPointToIntegral
  | IntegralToFixedPoint
  | FixedPointToBoolean
  | FloatingToIntegral
  | FloatingToBoolean
  | BooleanToSignedIntegral
  | FloatingCast
  | CPointerToObjCPointerCast
  | BlockPointerToObjCPointerCast
  | AnyPointerToBlockPointerCast
  | ObjCObjectLValueCast
  | FloatingRealToComplex
  | FloatingComplexToReal
  | FloatingComplexToBoolean
  | FloatingComplexCast
  | FloatingComplexToIntegralComplex
  | IntegralRealToComplex
  | IntegralComplexToReal
  | IntegralComplexToBoolean
  | IntegralComplexCast
  | IntegralComplexToFloatingComplex
  | ARCProduceObject
  | ARCConsumeObject
  | ARCReclaimReturnedObject
  | ARCExtendBlockObject
  | AtomicToNonAtomic
  | NonAtomicToAtomic
  | CopyAndAutoreleaseBlockObject
  | BuiltinFnToFnPtr
  | ZeroToOCLOpaqueType
  | AddressSpaceConversion
  | IntToOCLSampler
[@@deriving show]
