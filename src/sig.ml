module F = Format

module type NODE = sig
  type t

  val pp : F.formatter -> t -> unit
end

module type DECL = sig
  type t

  type kind = DeclKind.t

  val is_implicit : t -> bool

  val pp : F.formatter -> t -> unit
end

module type TYPE = sig
  type t

  type kind = TypeKind.t

  val pp : Format.formatter -> t -> unit
end

module type QUAL_TYPE = sig
  module Type : TYPE

  type t = { ty : Type.t; const : bool }

  val to_string : t -> string

  val pp : Format.formatter -> t -> unit
end

module type NAMED_DECL = sig
  include DECL

  val get_name : t -> string
end

module type VALUE_DECL = sig
  include NAMED_DECL

  module Decl : DECL

  module QualType : QUAL_TYPE

  val get_type : t -> QualType.t
end

module type FUNCTION_DECL = VALUE_DECL

module type VAR_DECL = VALUE_DECL

module type FIELD_DECL = VALUE_DECL

module type LABEL_DECL = NAMED_DECL

module type TYPEDEF_DECL = NAMED_DECL

module type RECORD_DECL = NAMED_DECL

module type TYPEDEC_DECL = NAMED_DECL

module type PARAM_VAR_DECL = VALUE_DECL

(* Statement *)
module type STMT = sig
  include NODE

  type kind = StmtKind.t

  val get_kind : t -> kind

  val get_kind_name : t -> string
end

module type COMPOUND_STMT = NODE

module type DECL_STMT = NODE

module type GOTO_STMT = NODE

module type IMPLICIT_CAST = NODE

module type EXPLICIT_CAST = NODE

module type INTEGER_LITERAL = NODE

module type FLOATING_LITERAL = NODE

module type RETURN_STMT = NODE

module type BINARY_OPERATOR = NODE

module type UNARY_EXPR_OR_TYPE_TRAIT_EXPR = NODE

module type UNARY_OPERATOR = NODE

module type DECL_REF_EXPR = NODE

module type IF_STMT = NODE

module type LABEL_STMT = NODE

module type WHILE_STMT = NODE

module type MEMBER_EXPR = NODE

module type CALL_EXPR = NODE

module type ARRAY_SUBSCRIPT_EXPR = sig
  include NODE

  val get_base : t -> t

  val get_idx : t -> t
end

(* Type *)

module type BUILTIN_TYPE = NODE

module type ADJUSTED_TYPE = sig
  include NODE

  module QualType : QUAL_TYPE

  val get_original_type : t -> QualType.t
end

module type DECAYED_TYPE = ADJUSTED_TYPE

module type ARRAY_TYPE = sig
  include NODE

  module QualType : QUAL_TYPE

  val get_element_type : t -> QualType.t
end

module type VARIABLE_ARRAY_TYPE = ARRAY_TYPE

module type FUNCTION_TYPE = sig
  include NODE

  module QualType : QUAL_TYPE

  val return_type : t -> QualType.t

  val param_types : t -> QualType.t list
end

module type POINTER_TYPE = NODE

module type ELABORATED_TYPE = NODE

module type RECORD_TYPE = NODE

module type TYPEDEF_TYPE = NODE
