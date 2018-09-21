echo "REPO CLEANUP"
echo "------------"

echo "Delete all Gitlab repos"
repo_ids=$(curl -fsSL -H "Private-Token: $GITLAB_TOKEN" 'https://gitlab.com/api/v4/projects?min_access_level=30'|jq '.[].id')
for id in $repo_ids; do
  curl -fsSL -H "Private-Token: $GITLAB_TOKEN" -X DELETE "https://gitlab.com/api/v4/projects/$id"
done

echo "Delete all Github repos"
repos=$(curl -fsSL -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/user/repos"|jq -r '.[] | .owner.login + "/" + .name')
for repo in $repos; do
  curl -fsSL -H "Authorization: token $GITHUB_TOKEN" -X DELETE "https://api.github.com/repos/$repo"
done
