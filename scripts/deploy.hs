{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}
import Shelly
import qualified Data.Text as T
import Data.Monoid
default (T.Text)

yn :: T.Text -> Sh Bool
yn prompt = do
    echo (prompt <> " [Yn]: ")
    response <- liftIO getLine
    case response of
        "Y" -> return True
        "y" -> return True
        "N" -> return False
        "n" -> return False
        _ -> yn prompt

git :: ShellCmd result => result
git = cmd "git"

generated_files =
    [ "*.html"
    , "favicon.*", "img", "fonts", "css", "js"
    , "subject", "posts", "stories"
    ]

main :: IO ()
main = shelly $ escaping False $ do
    cmd "git" "st"
    whenM (yn "Continue?") $ do
        git "checkout" "master"
        flip finally_sh (git "checkout" "src") $ do
            git "merge" "src"
            rm_rf `mapM_` generated_files
            sub $ do
                cd "src"
                cmd "runghc" "site.hs" "clean"
                cmd "runghc" "site.hs" "build"
            cmd "cp" "-r" "src/_site/*" "."
            git "add" `mapM_` generated_files
            git "com" "-m" "publish"
            git "push"
        echo "SUCCESS"