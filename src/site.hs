--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Set as Set
import           Data.Monoid
import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import           Hakyll
import           Text.Pandoc.Options


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- take 5 <$> loadAllPostsAndStories
            let indexCtx = mconcat
                    [ listField "posts" postCtx (return posts)
                    , defaultContext
                    ]
            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/intro.html" indexCtx
                >>= loadAndApplyTemplate "templates/base.html" indexCtx
                >>= relativizeUrls
    
    match (fromList ["about.md", "contact.md", "resources.md"]) $ do
        route $ setExtension "html"
        compile $ pandocExtCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls

    match "subject/*.html" $ do
        route $ idRoute
        compile $ do
            subject <- flip getMetadataField' "subject" =<< getUnderlying
            let sameSubject item = do
                let ident = itemIdentifier item
                subject' <- getMetadataField ident "subject"
                return $ subject' == Just subject
            posts <- filterM sameSubject =<< loadAllPostsAndStories
            let subjectCtx = mconcat
                    [ listField "posts" postCtx (return posts)
                    , defaultContext
                    ]
            getResourceBody
                >>= applyAsTemplate subjectCtx
                >>= loadAndApplyTemplate "templates/subject.html"  subjectCtx
                >>= loadAndApplyTemplate "templates/base.html"  subjectCtx
                >>= relativizeUrls

    match "subject/*/*.md" $ do
        route $ setExtension "html"
        compile $ pandocExtCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocExtCompiler
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= loadAndApplyTemplate "templates/base.html" postCtx
            >>= relativizeUrls

    match "stories/*" $ do
        route $ setExtension "html"
        compile $ pandocExtCompiler
            >>= loadAndApplyTemplate "templates/story.html" postCtx
            >>= loadAndApplyTemplate "templates/base.html" postCtx
            >>= relativizeUrls

    match "archive.html" $ do
        route idRoute
        compile $ do
            posts <- loadAllPostsAndStories
            let archiveCtx = mconcat
                    [ listField "posts" postCtx (return posts)
                    , defaultContext
                    ]
            getResourceBody
                >>= applyAsTemplate archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= loadAndApplyTemplate "templates/base.html" archiveCtx
                >>= relativizeUrls

    match "templates/**" $ compile templateCompiler

    match "js/*" $ do
        route idRoute
        compile copyFileCompiler
    match "css/*" $ do
        route idRoute
        compile compressCssCompiler
    match "img/*" $ do
        route idRoute
        compile copyFileCompiler
    match "fonts/*" $ do
        route idRoute
        compile copyFileCompiler
    match "favicon.*" $ do
        route idRoute
        compile copyFileCompiler


--------------------------------------------------------------------------------

loadFeed :: Maybe Int -> Compiler [String]
loadFeed limit = do
    contents <- itemBody <$> load "feed.md"
    return $ case limit of
        Nothing -> lines contents
        Just n -> take n $ lines contents

loadAllPostsAndStories = do
    posts <- loadAll "posts/*"
    stories <- loadAll "stories/*"
    recentFirst $ posts ++ stories

postCtx :: Context String
postCtx =
    dateField "date" "%Y-%m-%d" `mappend`
    defaultContext

pandocExtCompiler = pandocCompilerWith rOpts wOpts
    where
    rOpts = def { readerExtensions = Set.fromList [Ext_footnotes] }
    wOpts = def { writerExtensions = Set.fromList [Ext_footnotes] }