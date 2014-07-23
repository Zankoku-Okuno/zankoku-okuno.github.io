--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid
import           Control.Applicative
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- take 5 <$> loadAllPostsAndStories
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/intro.html" indexCtx
                >>= loadAndApplyTemplate "templates/base.html" indexCtx
                >>= relativizeUrls
    
    match (fromList ["about.md", "contact.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls

    match "subject/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= loadAndApplyTemplate "templates/base.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= loadAndApplyTemplate "templates/base.html" postCtx
            >>= relativizeUrls

    match "stories/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/story.html" postCtx
            >>= loadAndApplyTemplate "templates/base.html" postCtx
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- loadAllPostsAndStories
            let archiveCtx = mconcat
                    [ listField "posts" postCtx (return posts)
                    , constField "title" "Archives"
                    , defaultContext
                    ]

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= loadAndApplyTemplate "templates/base.html" archiveCtx
                >>= relativizeUrls

    match "templates/**" $ compile templateCompiler

    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler
    match "img/*" $ do
        route   idRoute
        compile copyFileCompiler
    match "fonts/*" $ do
        route   idRoute
        compile copyFileCompiler
    match "favicon.*" $ do
        route   idRoute
        compile copyFileCompiler


--------------------------------------------------------------------------------

loadAllPostsAndStories = do
    posts <- loadAll "posts/*"
    stories <- loadAll "stories/*"
    recentFirst $ posts ++ stories

postCtx :: Context String
postCtx =
    dateField "date" "%Y-%m-%d" `mappend`
    defaultContext
