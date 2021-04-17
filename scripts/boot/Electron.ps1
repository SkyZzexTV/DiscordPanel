<#
 * File: Electron.ps1
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

Else {
    Start-Sleep -Seconds 0.1
    Write-Host "[ERROR]: INVALID LANGUAGE."
    Exit
}

<#---------------------------------------
Electron Boot-up
---------------------------------------#>

Write-Host "[DiscordPanel]: $($locales.checking_system)"
If (Test-Path "..\..\electron\main.js") {
    Write-Host "[DiscordPanel]: $($locales.check_success)"
    Write-Host

    Write-Host "[DiscordPanel]: $($locales.booting)"
    Write-Host

    Set-Location ..
    Set-Location ..

    Set-Location electron

    npm start

    Write-Host "[DiscordPanel]: $($locales.done)"

    $caption = ""
    $description = ""

    Write-Host
    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((
            New-Object Management.Automation.Host.ChoiceDescription `
                -ArgumentList `
                "&Go back.",
            "$($locales.go_back_help)"
        ))
    $choices.Add((
            New-Object Management.Automation.Host.ChoiceDescription `
                -ArgumentList `
                "&Exit",
            "$($locales.exit_help)"
        ))

    $selection = $host.ui.PromptForChoice($empty, $empty2, $choices, -1)
    Write-Host

    switch ($selection) {
        0 {
            Set-Location ..
            Set-Location scripts
            .\Selection.ps1
        }
        1 {
            Exit
        }
    }

}
Else {
    Write-Host "[DiscordPanel]: $($locales.checking_failure)"
    Write-Host

    Write-Host "[DiscordPanel]: $($locales.check_main)"
    Write-Host "[DiscordPanel]: $($locales.get_help)"
}
Write-Host
