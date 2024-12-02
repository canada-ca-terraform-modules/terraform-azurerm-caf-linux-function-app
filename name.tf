locals {
  anti-pattern-regex = "/[//\"'\\[\\]:|<>+=;,?*@&]/"
  func-name = replace("${var.env}-${var.group}-${var.project}-${var.userDefinedString}-func", local.anti-pattern-regex, "")
}