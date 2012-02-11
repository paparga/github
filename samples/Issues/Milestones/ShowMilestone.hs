module ShowMilestone where

import qualified Github.Issues.Milestones as Github
import Data.List (intercalate)
import Data.Default (def)

main = do
  possibleMilestone <- Github.milestone def "thoughtbot" "paperclip" 2
  case possibleMilestone of
       (Left error) -> putStrLn $ "Error: " ++ show error
       (Right milestone) ->
         putStrLn $ formatMilestone milestone

formatMilestone milestone =
  (Github.milestoneTitle milestone) ++ ", as created by " ++
    (loginName milestone) ++ " on " ++ (createdAt milestone) ++
    formatDueOn (Github.milestoneDueOn milestone) ++ " and has the " ++
    (Github.milestoneState milestone) ++ " status"

formatDueOn Nothing = ""
formatDueOn (Just milestoneDate) = ", is due on " ++ dueOn milestoneDate

loginName = Github.githubOwnerLogin . Github.milestoneCreator
createdAt = show . Github.fromGithubDate . Github.milestoneCreatedAt
dueOn = show . Github.fromGithubDate
