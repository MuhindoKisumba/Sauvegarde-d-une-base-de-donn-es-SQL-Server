###############################################################################
# SAUVEGARDE AUTOMATIQUE D'UNE BASE DE DONNÉES SQL SERVER
# Compatible : SQL Server 2012 à SQL Server 2022
# Nécessite le module SqlServer :
# Install-Module SqlServer -Scope CurrentUser
# Auteur : MUHINDO KISUMBA Abdiel
###############################################################################

#-----------------------------
# PARAMÈTRES
#-----------------------------
$Serveur      = "localhost"                  # Nom du serveur SQL
$Base         = "Gestion"                    # Nom de la base de données
$DossierBak   = "C:\SQLBackups"              # Dossier des sauvegardes
$Date         = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$FichierBak   = Join-Path $DossierBak "$Base`_$Date.bak"

#-----------------------------
# CRÉATION DU DOSSIER SI ABSENT
#-----------------------------
if (!(Test-Path $DossierBak))
{
    New-Item -ItemType Directory -Path $DossierBak -Force | Out-Null
}

#-----------------------------
# DÉMARRAGE DU JOURNAL
#-----------------------------
$Journal = Join-Path $DossierBak "Sauvegarde_SQL.log"

Add-Content $Journal "==========================================================="
Add-Content $Journal "Début : $(Get-Date)"
Add-Content $Journal "Serveur : $Serveur"
Add-Content $Journal "Base : $Base"

try
{
    # Vérification du module SqlServer
    if (-not (Get-Module -ListAvailable -Name SqlServer))
    {
        throw "Le module 'SqlServer' n'est pas installé."
    }

    Import-Module SqlServer -ErrorAction Stop

    # Sauvegarde complète
    Backup-SqlDatabase `
        -ServerInstance $Serveur `
        -Database $Base `
        -BackupFile $FichierBak `
        -CompressionOption On `
        -Initialize `
        -ErrorAction Stop

    Add-Content $Journal "Sauvegarde réussie."
    Add-Content $Journal "Fichier : $FichierBak"

    Write-Host ""
    Write-Host "============================================="
    Write-Host "SAUVEGARDE EFFECTUÉE AVEC SUCCÈS"
    Write-Host "Serveur : $Serveur"
    Write-Host "Base : $Base"
    Write-Host "Fichier : $FichierBak"
    Write-Host "============================================="
}
catch
{
    Add-Content $Journal "ERREUR : $($_.Exception.Message)"

    Write-Host ""
    Write-Host "============================================="
    Write-Host "ÉCHEC DE LA SAUVEGARDE"
    Write-Host $_.Exception.Message
    Write-Host "============================================="
}
finally
{
    Add-Content $Journal "Fin : $(Get-Date)"
    Add-Content $Journal ""
}