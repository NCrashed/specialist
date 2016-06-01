module Common(
    module ReExport
  , showt
  , showr 
  , showf
  ) where 

import Text.LaTeX as ReExport
import Text.LaTeX.Base.Class as ReExport
import Data.Text (pack, Text)
import Text.Printf

showt :: Show a => a -> Text
showt = pack . show 

showr :: (Show a, LaTeXC l) => a -> l
showr = raw . showt 

showf :: (LaTeXC l, Floating a, PrintfArg a) => a -> l 
showf = raw . pack . printf "%.2f"
