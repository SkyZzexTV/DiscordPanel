<#
 * File: Start.ps1
 * Author: SkyZzexTV
 * License: GPL-3.0
#>

<#---------------------------------------
Language Translator
---------------------------------------#>

$config = (Get-Content "../../config/config.json" -Raw) | ConvertFrom-Json
$package = (Get-Content "../../package.json" -Raw) | ConvertFrom-Json

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
DiscordPanel Web Boot-up
---------------------------------------#>

Write-Host ""
Write-Host "[DiscordPanel]: $($locales.checking_system)"
If (Test-Path "..\..\index.html") {
    Write-Host "[DiscordPanel]: $($locales.check_success)"
    Write-Host

    Write-Host "[DiscordPanel]: $($locales.booting)"
    Write-Host

    Start-Process '../../index.html'

    Write-Host "[DiscordPanel]: $($locales.done)"

    Write-Host
    Write-Host "DiscordPanel v$($package.version)"
    Write-Host "Copyright $([char]0x00A9) 2020 Sanjay Sunil"

    $caption = ""
    $description = ""

    Write-Host
    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((
            New-Object Management.Automation.Host.ChoiceDescription `
                -ArgumentList `
                "&1 $($locales.go_back)",
            "$($locales.go_back_help)"
        ))
    $choices.Add((
            New-Object Management.Automation.Host.ChoiceDescription `
                -ArgumentList `
                "&2 $($locales.exit)",
            "$($locales.exit_help)"
        ))

    $selection = $host.ui.PromptForChoice($empty, $empty2, $choices, -1)

    Write-Host

    switch ($selection) {
        0 {
            Set-Location ..
            .\Selection.ps1
        }
        1 {
            Exit
        }
    }

}
Else {
    Write-Host "[DiscordPanel]: $($locales.check_failure)"
    Write-Host

    Write-Host "[DiscordPanel]: $($locales.check_index)"
    Write-Host "[DiscordPanel]: $($locales.get_help)"
}
Write-Host
