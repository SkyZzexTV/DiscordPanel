<#
 * File: Support.ps1
 * Author: SkyZzexTV
 * License: GPL-3.0
#>

Clear-Host

<#---------------------------------------
Language Translator
---------------------------------------#>

$config = (Get-Content "../../config/config.json" -Raw) | ConvertFrom-Json

If ($config.language -eq 'en') {
	$locales = (Get-Content '../../locales/en/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'fr') {
	$locales = (Get-Content '../../locales/fr/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'de') {
	$locales = (Get-Content '../../locales/de/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'es') {
	$locales = (Get-Content '../../locales/es/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'no') {
	$locales = (Get-Content '../../locales/no/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'ro') {
	$locales = (Get-Content '../../locales/ro/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'ru') {
	$locales = (Get-Content '../../locales/ru/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'hu') {
	$locales = (Get-Content '../../locales/hu/panel.json' -Raw) | ConvertFrom-Json
}

ElseIf ($config.language -eq 'nl') {
	$locales = (Get-Content '../../locales/nl/panel.json' -Raw) | ConvertFrom-Json
}

Else {
    Start-Sleep -Seconds 0.1
    Write-Host "[ERROR]: INVALID LANGUAGE."
    Exit
}

<#---------------------------------------
Support
---------------------------------------#>

$caption = "$($locales.support):
 "
$description = "[DiscordPanel]: $($locales.select_option)
 "

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((
    New-Object Management.Automation.Host.ChoiceDescription `
      -ArgumentList `
      "&1 $($locales.discordserver)",
    "$($locales.discord_help)"
  ))
$choices.Add((
    New-Object Management.Automation.Host.ChoiceDescription `
      -ArgumentList `
      "&2 $($locales.submit_issue)",
    "$($locales.issue_help)"
  ))
$choices.Add((
    New-Object Management.Automation.Host.ChoiceDescription `
      -ArgumentList `
      "&3 $($locales.go_back)",
    "$($locales.go_back_help)"
  ))
$choices.Add((
    New-Object Management.Automation.Host.ChoiceDescription `
      -ArgumentList `
      "&4 $($locales.exit)",
    "$($locales.exit_help)"
  ))

$selection = $host.ui.PromptForChoice($caption, $description, $choices, -1)
Write-Host

switch ($selection) {
  0 {
    Start-Process 'https://discord.gg/dpYwZT7pNG'
    .\Support.ps1
  }
  1 {
    .\Settings.ps1
  }
  2 {
    Exit
  }
}
