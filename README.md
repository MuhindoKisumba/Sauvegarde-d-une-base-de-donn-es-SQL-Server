#  README – Script de Sauvegarde Automatique d'une Base de Données SQL Server avec PowerShell

##  Description

Ce script PowerShell permet d'automatiser la sauvegarde complète d'une base de données Microsoft SQL Server.

Il effectue les opérations suivantes :

- Vérifie que le module **SqlServer** est installé.
- Importe automatiquement le module PowerShell.
- Crée le dossier de sauvegarde s'il n'existe pas.
- Génère un nom de fichier unique contenant la date et l'heure.
- Lance une sauvegarde complète de la base SQL Server.
- Active la compression de la sauvegarde.
- Initialise le fichier de sauvegarde.
- Génère un journal (log) contenant toutes les opérations.
- Affiche le résultat de l'exécution dans la console.
- Gère automatiquement les erreurs avec `Try / Catch / Finally`.

---

# Fonctionnalités

-  Sauvegarde complète (.bak)
-  Compression de la sauvegarde
-  Horodatage automatique
-  Création automatique du dossier de sauvegarde
-  Journalisation des opérations
-  Gestion des exceptions
-  Compatible avec le Planificateur de tâches Windows
-  Facilement personnalisable

---

# Compatibilité

Le script est compatible avec :

- SQL Server 2012
- SQL Server 2014
- SQL Server 2016
- SQL Server 2017
- SQL Server 2019
- SQL Server 2022

Fonctionne sous :

- Windows 10
- Windows 11
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022

PowerShell :

- Windows PowerShell 5.1
- PowerShell 7+

---

# Prérequis

## Installer le module SqlServer

```powershell
Install-Module SqlServer -Scope CurrentUser
```

Si nécessaire :

```powershell
Set-ExecutionPolicy RemoteSigned
```

---

# Paramètres du script

| Variable | Description |
|-----------|-------------|
| `$Serveur` | Nom ou adresse IP du serveur SQL Server |
| `$Base` | Nom de la base de données à sauvegarder |
| `$DossierBak` | Dossier de destination des sauvegardes |
| `$Date` | Date et heure utilisées dans le nom du fichier |
| `$FichierBak` | Chemin complet du fichier `.bak` |
| `$Journal` | Fichier journal des opérations |

---

# Fonctionnement

## 1. Initialisation

Le script charge les paramètres de connexion et prépare les chemins de sauvegarde.

---

## 2. Vérification

Il vérifie :

- la présence du module SqlServer
- l'existence du dossier de sauvegarde

---

## 3. Création du dossier

Si le dossier n'existe pas :

```text
C:\SQLBackups
```

il est automatiquement créé.

---

## 4. Journalisation

Toutes les opérations sont enregistrées dans :

```text
Sauvegarde_SQL.log
```

Le journal contient :

- Date de début
- Serveur
- Base
- Succès
- Erreurs
- Date de fin

---

## 5. Sauvegarde SQL

Le script exécute automatiquement :

- sauvegarde complète
- compression
- initialisation du fichier
- création du fichier .bak

Exemple :

```text
Gestion_2026-06-27_18-30-45.bak
```

---

## 6. Gestion des erreurs

Toutes les erreurs sont capturées grâce à :

```powershell
try
{
}
catch
{
}
finally
{
}
```

Les erreurs sont :

- affichées à l'écran
- enregistrées dans le journal

---

# Arborescence générée

```text
C:\
│
└── SQLBackups
      │
      ├── Gestion_2026-06-27_18-30-45.bak
      ├── Gestion_2026-06-28_18-30-45.bak
      ├── Gestion_2026-06-29_18-30-45.bak
      │
      └── Sauvegarde_SQL.log
```

---

# Exemple de journal

```text
===========================================================
Début : 27/06/2026 18:30:45

Serveur : localhost

Base : Gestion

Sauvegarde réussie.

Fichier :
C:\SQLBackups\Gestion_2026-06-27_18-30-45.bak

Fin : 27/06/2026 18:31:12
```

---

# Personnalisation

Modifier facilement :

```powershell
$Serveur = "SQLPROD01"

$Base = "Comptabilite"

$DossierBak = "D:\Backups"
```

Le reste du script fonctionne automatiquement.

---

# Planification automatique

Le script peut être exécuté automatiquement :

- Tous les jours
- Toutes les heures
- Toutes les semaines
- Tous les mois

à l'aide du **Planificateur de tâches Windows**.

Exemple :

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\Scripts\Sauvegarde_SQL.ps1
```

---

# Bonnes pratiques

- Utiliser un disque dédié pour les sauvegardes.
- Vérifier régulièrement l'intégrité des fichiers `.bak`.
- Tester les restaurations dans un environnement de préproduction.
- Chiffrer les sauvegardes contenant des données sensibles.
- Conserver plusieurs générations de sauvegardes (rotation).
- Répliquer les sauvegardes sur un stockage externe ou dans le cloud.
- Surveiller l'espace disque disponible.
- Restreindre les droits d'accès au dossier de sauvegarde.

---

# Avantages

- Automatisation complète
- Réduction des erreurs humaines
- Sauvegardes horodatées
- Journalisation détaillée
- Code clair et maintenable
- Déploiement rapide
- Compatible avec les environnements de production
- Réutilisable pour plusieurs bases de données

---

# Cas d'utilisation

Ce script est particulièrement adapté pour :

- Sauvegardes quotidiennes des bases SQL Server
- Plans de reprise après sinistre (Disaster Recovery)
- Administration de serveurs SQL
- Automatisation des tâches d'exploitation
- Environnements de développement et de test
- PME, grandes entreprises et administrations
- Laboratoires de formation SQL Server

---

# Auteur
MUHINDO KISUMBA ABDIEL

Script PowerShell professionnel de sauvegarde automatique SQL Server avec journalisation, gestion des erreurs et compatibilité avec SQL Server 2012 à 2022, conçu pour faciliter l'automatisation des sauvegardes et renforcer la sécurité des données.
