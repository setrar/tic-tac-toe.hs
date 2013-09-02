import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import TTT.Position

main = hspec $ do
  describe "TTT.Position" $ do
    context "initPosition" $ do
      it "should create an initial position" $ do
        initPosition `shouldBe` (Position ("   "++"   "++"   ") 'X')
    context "render" $ do
      it "should render a position" $ do
        render (Position ("XX "
                        ++" OO"
                        ++"   ") 'X') `shouldBe` " X | X | 2 \n"
                                              ++ "-----------\n"
                                              ++ " 3 | O | O \n"
                                              ++ "-----------\n"
                                              ++ " 6 | 7 | 8 \n"
    context "move" $ do
      it "should make a move" $ do
        (Position ("XX "
                 ++"   "
                 ++" OO") 'X') `move` 3 `shouldBe` (Position ("XX "
                                                            ++"X  "
                                                            ++" OO") 'O')
    context "possibleMoves" $ do
      it "should list possible moves for a position" $ do
        possibleMoves (Position ("XX "
                               ++" O "
                               ++"   ") 'O') `shouldBe` [2,3,5,6,7,8]
    context "isWinFor" $ do
      it "should determine no win" $ do
        initPosition `isWinFor` 'X' `shouldBe` False
      it "should determine a win for X on first row" $ do
        (Position ("XXX"
                 ++"   "
                 ++"   ") 'X') `isWinFor` 'X' `shouldBe` True
      it "should determine a win for X on second row" $ do
        (Position ("   "
                 ++"XXX"
                 ++"   ") 'X') `isWinFor` 'X' `shouldBe` True
      it "should determine a win for X on third row" $ do
        (Position ("   "
                 ++"   "
                 ++"XXX") 'X') `isWinFor` 'X' `shouldBe` True
      it "should determine a win for O on first col" $ do
        (Position ("O  "
                 ++"O  "
                 ++"O  ") 'X') `isWinFor` 'O' `shouldBe` True
      it "should determine a win for O on second col" $ do
        (Position (" O "
                 ++" O "
                 ++" O ") 'X') `isWinFor` 'O' `shouldBe` True
      it "should determine a win for O on third col" $ do
        (Position ("  O"
                 ++"  O"
                 ++"  O") 'X') `isWinFor` 'O' `shouldBe` True
      it "should determine a win for O on major diagonal" $ do
        (Position ("O  "
                 ++" O "
                 ++"  O") 'X') `isWinFor` 'O' `shouldBe` True
      it "should determine a win for O on minor diagonal" $ do
        (Position ("  O"
                 ++" O "
                 ++"O  ") 'X') `isWinFor` 'O' `shouldBe` True
    context "minimax" $ do
      it "should determine a win for X" $ do
        minimax (Position ("XXX"++"   "++"   ") 'X') `shouldBe` 100
      it "should determine a win for O" $ do
        minimax (Position ("OOO"++"   "++"   ") 'X') `shouldBe` (-100)
      it "should determine a draw" $ do
        minimax (Position ("OXO"
                         ++"XOX"
                         ++"XOX") 'X') `shouldBe` 0
      it "should determine a win for X in 1 move" $ do
        minimax (Position ("X  "
                         ++" X "
                         ++"   ") 'X') `shouldBe` 107
      it "should determine a win for O in 1 move" $ do
        minimax (Position ("O  "
                         ++" O "
                         ++"   ") 'O') `shouldBe` (-107)
    context "bestMove" $ do
      it "should determine the best move" $ do
        bestMove (Position ("   "
                          ++"   "
                          ++"   ") 'X') `shouldBe` []
