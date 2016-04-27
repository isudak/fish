function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ':'

  # PWD
  set -l realhome ~
  set_color $fish_color_cwd
  echo -n $PWD | sed -e "s|^$realhome|~|"
  set_color normal

  echo ' ('(git_prompt)')'
  #__terlar_git_prompt

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '$ '
  set_color normal
end
