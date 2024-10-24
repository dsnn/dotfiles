set quiet
alias t := test

default:
  just -l

test:
  pre-commit run -a
