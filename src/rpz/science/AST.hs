data AST = 
    Const Double
  | Variable Int
  | Function Operand ![AST]

data Operand = Operand {
  operandName :: Text
, operandType :: OperandType 
, operandArity :: Int 
, operandPriority :: Int
, operandImpl :: ASTPoint -> Double
}

data OperandType = 
    InfixOperand
  | PrefixOperand

type ASTPoint = [Double]