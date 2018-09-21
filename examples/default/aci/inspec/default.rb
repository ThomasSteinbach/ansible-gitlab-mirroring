control 'public-repos-on-github' do
  title 'Public source repos on Github'
  desc '
    Public repos from the source repo must be
    publicly accessible on the target Github repo
  '
  describe http('https://github.com/ansibleci-test/publicRepo') do
    its('status') { should cmp 200 }
  end
  describe http('https://github.com/ansibleci-test/publicGroup-publicGroupRepo') do
    its('status') { should cmp 200 }
  end
  describe http('https://github.com/ansibleci-test/publicGroup-publicSubgroup-publicSubgroupRepo') do
    its('status') { should cmp 200 }
  end

end

control 'non-public-repos-on-github' do
  title 'Non-public source repos on Github'
  desc '
    All non-public repos from the source repo must not
    be publicly accessible on the target Github repo
  '
  describe http('https://github.com/ansibleci-test/internalRepo') do
    its('status') { should cmp 404 }
  end
  describe http('https://github.com/ansibleci-test/privateRepo') do
    its('status') { should cmp 404 }
  end
end

control 'excluded-repos-on-github' do
  title 'Excluded repos on Github'
  desc '
    Excluded repos should not be mirrored to Github
  '
  describe http('https://github.com/ansibleci-test/config') do
    its('status') { should cmp 404 }
  end
end


control 'public-repos-on-gitlab' do
  title 'Public source repos on Gitlab'
  desc '
    Public repos from the source repo must be
    publicly accessible on the target Gitlab repo
  '
  describe http('https://gitlab.com/ansibleci-test/publicrepo') do
    its('status') { should cmp 200 }
  end
  describe http('https://gitlab.com/ansibleci-test/publicgroup-publicgrouprepo') do
    its('status') { should cmp 200 }
  end
  describe http('https://gitlab.com/ansibleci-test/publicgroup-publicsubgroup-publicsubgrouprepo') do
    its('status') { should cmp 200 }
  end
end

control 'non-public-repos-on-gitlab' do
  title 'Non-public source repos on Gitlab'
  desc '
    All non-public repos from the source repo must not
    be publicly accessible on the target Github repo
    for not logged in users. They should be redircted
    to the login page (302).
  '
  describe http('https://gitlab.com/ansibleci-test/internalrepo') do
    its('status') { should cmp 302 }
  end
  describe http('https://gitlab.com/ansibleci-test/privaterepo') do
    its('status') { should cmp 302 }
  end

end

control 'non-public-repos-for-gitlab-owner' do
  title 'Non-public source repos for Gitlab owner'
  desc '
    All non-public repos from the source repo must be
    publicly accessible on the target Github repo
    for the logged in owner
  '
  describe http('https://gitlab.com/ansibleci-test/internalrepo',
               headers: {'Private-Token' => ENV['GITLAB_TOKEN']}) do
    its('status') { should cmp 200 }
  end
  describe http('https://gitlab.com/ansibleci-test/privaterepo',
               headers: {'Private-Token' => ENV['GITLAB_TOKEN']}) do
    its('status') { should cmp 200 }
  end
end

control 'non-public-repos-for-gitlab-internals' do
  title 'Non-public source repos for Gitlab internals'
  desc '
    All non-public repos from the source repo must not
    be publicly accessible on the target Github repo
    for the logged in users (but not owners)
  '
  describe http('https://gitlab.com/ansibleci-test/internalrepo',
               headers: {'Private-Token' => ENV['GITLAB_TOKEN_2']}) do
    its('status') { should cmp 404 }
  end
  describe http('https://gitlab.com/ansibleci-test/privaterepo',
               headers: {'Private-Token' => ENV['GITLAB_TOKEN_2']}) do
    its('status') { should cmp 403 }
  end
end

control 'excluded-repos-on-gitlab' do
  title 'Excluded repos on Gitlab'
  desc '
    Excluded repos should not be mirrored to Gitlab and thus
    not be accessible for logged in users, owners and others.
  '
  describe http('https://gitlab.com/ansibleci-test/config') do
    its('status') { should cmp 302 }
  end
  describe http('https://gitlab.com/ansibleci-test/config',
               headers: {'Private-Token' => ENV['GITLAB_TOKEN']}) do
    its('status') { should cmp 404 }
  end
end
