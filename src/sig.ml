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

  val dump : t -> unit
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

module type ENUM_DECL = NAMED_DECL

module type RECORD_DECL = sig
  include NAMED_DECL

  module Decl : DECL

  val is_anonymous : t -> bool

  val is_struct : t -> bool

  val is_union : t -> bool

  val field_begin : t -> t option

  val field_list_internal : t -> t list

  val field_list : t -> Decl.t list

  val iter_field : (Decl.t -> unit) -> t -> unit
end

module type TYPEDEC_DECL = NAMED_DECL

module type PARAM_VAR_DECL = VALUE_DECL

(* Statement *)
module type STMT = sig
  include NODE

  type kind = StmtKind.t

  val get_kind : t -> kind

  val get_kind_name : t -> string
end

module type EXPR = sig
  include STMT

  module QualType : QUAL_TYPE

  val get_type : t -> QualType.t
end

module type COMPOUND_STMT = NODE

module type DECL_STMT = NODE

module type GOTO_STMT = NODE

module type IMPLICIT_CAST = NODE

module type EXPLICIT_CAST = NODE

module type IMPLICIT_VALUE_INIT_EXPR = NODE

module type INIT_LIST_EXPR = NODE

module type CHARACTER_LITERAL = sig
  include EXPR

  type kind

  val get_kind : t -> kind

  val get_value : t -> int
end

module type INTEGER_LITERAL = NODE

module type FLOATING_LITERAL = NODE

module type CONSTANT_EXPR = sig
  include EXPR

  val get_sub_expr : t -> t
end

module type STMT_EXPR = sig
  include EXPR

  val get_sub_stmt : t -> t
end

module type STRING_LITERAL = sig
  include EXPR

  val get_string : t -> string
end

module type PREDEFINED_EXPR = sig
  include EXPR

  module StringLiteral : STRING_LITERAL

  type kind

  val get_function_name : t -> StringLiteral.t
end

module type RETURN_STMT = NODE

module type BINARY_OPERATOR = NODE

module type UNARY_EXPR_OR_TYPE_TRAIT_EXPR = NODE

module type UNARY_OPERATOR = sig
  include STMT

  type kind

  val get_kind : t -> kind

  val has_side_effect : t -> bool
end

module type DECL_REF_EXPR = NODE

module type IF_STMT = NODE

module type LABEL_STMT = NODE

module type WHILE_STMT = NODE

module type MEMBER_EXPR = NODE

module type OPAQUE_VALUE_EXPR = sig
  include EXPR

  module Expr : EXPR

  val get_source_expr : t -> Expr.t
end

module type PAREN_EXPR = sig
  include EXPR

  module Expr : EXPR

  val get_sub_expr : t -> Expr.t
end

module type CALL_EXPR = NODE

module type CASE_STMT = sig
  include STMT

  module Stmt : STMT

  module Expr : EXPR

  val get_lhs : t -> Expr.t

  val get_rhs : t -> Expr.t

  val get_sub_stmt : t -> Stmt.t
end

module type DEFAULT_STMT = sig
  include STMT

  module Stmt : STMT

  val get_sub_stmt : t -> Stmt.t
end

module type SWITCH_STMT = sig
  include STMT

  module Stmt : STMT

  module Expr : EXPR

  val get_cond : t -> Expr.t

  val get_body : t -> Stmt.t
end

module type BINARY_CONDITIONAL_OPERATOR = sig
  include EXPR

  val get_cond : t -> t

  val get_true_expr : t -> t

  val get_false_expr : t -> t
end

module type CONDITIONAL_OPERATOR = sig
  include EXPR

  val get_cond : t -> t

  val get_true_expr : t -> t

  val get_false_expr : t -> t
end

module type ARRAY_SUBSCRIPT_EXPR = sig
  include NODE

  val get_base : t -> t

  val get_idx : t -> t
end

module type VA_ARG_EXPR = sig
  include EXPR

  val get_sub_expr : t -> t
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

module type CONSTANT_ARRAY_TYPE = sig
  include ARRAY_TYPE

  val get_size : t -> Int64.t
end

module type VARIABLE_ARRAY_TYPE = sig
  include ARRAY_TYPE

  module Expr : EXPR

  val get_size_expr : t -> Expr.t
end

module type FUNCTION_TYPE = sig
  include NODE

  module QualType : QUAL_TYPE

  val return_type : t -> QualType.t

  val param_types : t -> QualType.t list
end

module type PAREN_TYPE = sig
  include NODE

  module QualType : QUAL_TYPE

  val desugar : t -> QualType.t
end

module type POINTER_TYPE = NODE

module type ELABORATED_TYPE = NODE

module type ENUM_TYPE = NODE

module type RECORD_TYPE = NODE

module type TYPE_OF_EXPR_TYPE = sig
  include TYPE

  module Expr : EXPR

  val get_underlying_expr : t -> Expr.t
end

module type TYPEDEF_TYPE = NODE
