{-# LANGUAGE OverloadedStrings #-}
module Common(
    module ReExport
  , showt
  , showr 
  , showf
  , weightedSummTabular
  , weightedSummTabular'
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

type Variant = Text 
type Factor = Text 

-- | Non-normalized weighted summ tabular
weightedSummTabular :: [(Factor, Double)] -> [(Variant, [Int])] -> LaTeX
weightedSummTabular factors datum = tabular (Just Center) (LeftColumn:variantCols) $
  ("Критерии" & foldr1 (&) (footnotesize . raw . fst <$> datum)) <> lnbk <> hline <> hline
    <> mconcat rows
  where 
    variantCols = concat $ (const [VerticalLine, CenterColumn]) <$> datum
    rows = mkrow <$> [0 .. length factors - 1]
    isLast i = i == length factors - 1
    mkrow i = (raw (fst $ factors !! i) & (foldr1 (&) $ showr.(!! i).snd <$> datum)) <> lnbk <> (if isLast i then mempty else hline)

-- | Normalized weighted summ tabular
weightedSummTabular' :: [(Factor, Double)] -> [(Variant, [Int])] -> LaTeX
weightedSummTabular' factors datum = tabular (Just Center) (LeftColumn:VerticalLine:CenterColumn:VerticalLine:variantCols) $
  ("Критерии" & raw "$\\alpha$" & foldr1 (&) (footnotesize . raw . fst <$> datum)) <> lnbk <> hline <> hline
    <> mconcat rows
    <> lastRow 
  where 
    datum' = fmap normalize . snd <$> datum
    variantCols = concat $ (const [VerticalLine, CenterColumn]) <$> datum
    rows = mkrow <$> [0 .. length factors - 1]
    isLast i = i == length factors - 1
    mkrow i = (raw (fst $ factors !! i) 
      & (showf . snd $ factors !! i)
      & mkrow' i)
      <> lnbk <> hline <> (if isLast i then hline else mempty)
    mkrow' i = foldr1 (&) $ showf.(!! i) <$> datum'

    lastRow = ("Итого" & showf sumFacts & sumRows) <> lnbk
    sumFacts = sum $ snd <$> factors
    sumRows = foldr1 (&) $ fmap stressMaxVal sumRowsVals
    sumRowsVals = (sum . zipWith (*) (fmap snd factors)) <$> datum'
    maxVal = maximum sumRowsVals
    stressMaxVal v = if v == maxVal then textbf $ showf v else showf v
    normalize v = case v of 
      1 -> 0
      2 -> 0.25
      3 -> 0.5 
      4 -> 0.75
      5 -> 1
      _ -> 1