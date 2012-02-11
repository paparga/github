module ShowComments where

import qualified Github.Gists.Comments as Github
import Data.List (intercalate)
import Data.Default (def)

main = do
  possibleComments <- Github.commentsOn def "1174060"
  case possibleComments of
    (Left error)  -> putStrLn $ "Error: " ++ (show error)
    (Right comments) -> putStrLn $ intercalate "\n\n" $ map formatComment comments

formatComment comment =
  (Github.githubOwnerLogin $ Github.gistCommentUser comment) ++ "\n" ++
    (formatGithubDate $ Github.gistCommentUpdatedAt comment) ++ "\n\n" ++
    (Github.gistCommentBody comment)

formatGithubDate = show . Github.fromGithubDate
