# Documentation du projet People Pulse

## Staging

### 00_transfo_donnees_rh
{% docs doc_00_transfo_donnees_rh %}
Données de base RH nettoyées (âge, poste, salaire). La clé primaire (PK) est l'ID de l'employé.
{% enddocs %}

{% docs cle_00_transfo_donnees_rh %}
Test sur la **clé primaire** qui est l'id de l'employé : un employé ne peut avoir qu'un ID et un ID ne peut être attribué qu'à un employé unique
{% enddocs %}


### 01_transfo_historique_carriere
{% docs doc_01_transfo_historique_carriere %}
Historique des promotions, mobilités et évolutions salariales.
{% enddocs %}

{% docs cle_01_transfo_historique_carriere %}
Test sur la **clé primaire** qui est l'id de l'employé : un employé ne peut avoir qu'un ID et un ID ne peut être attribué qu'à un employé unique
{% enddocs %}

### 02_transfo_absenteisme
{% docs doc_02_transfo_absenteisme %}
Données d'absentéisme par employé.
{% enddocs %}

{% docs cle_02_transfo_absenteisme %}
Test sur la **clé primaire** qui est l'id de l'employé : un employé ne peut avoir qu'un ID et un ID ne peut être attribué qu'à un employé unique
{% enddocs %}

 
### 03_transfo_enquete_satisfaction
{% docs doc_03_transfo_enquete_satisfaction %}
Scores d'enquêtes de satisfaction (sentiment, NPS). Une enquête par employé par date.

**Test sur une clé combinée** : il ne peut y avoir qu'une réponse par jour par employé
{% enddocs %}


### 04_transfo_feedback360
{% docs doc_04_transfo_feedback360 %}
Scores de feedback 360 (compétences, leadership) par évaluation.

**Test sur une clé combinée** : il ne peut y avoir qu'une réponse par jour par employé
{% enddocs %}



 
### 05_transfo_histo_mensuel_20_24
{% docs doc_05_transfo_histo_mensuel_20_24 %}
Métriques macro RH et coûts (effectif, turnover) agrégées au mois.
{% enddocs %}

{% docs cle_05_transfo_histo_mensuel_20_24 %}
Test sur la **clé primaire**  par mois/année
{% enddocs %}

 
### 06_transfo_cohorte
{% docs doc_06_transfo_cohorte %}
Taux de rétention par cohorte d'embauche
{% enddocs %}

{% docs cle_06_transfo_cohorte %}
Test sur la **clé primaire** qui est le mois d'embauche
{% enddocs %}

 
### 07_transfo_donnees_contextuelles
{% docs doc_07_transfo_donnees_contextuelles %}
Données macroéconomiques et marché du travail liées à la période.{% enddocs %}

{% docs cle_07_transfo_donnees_contextuelles %}
Test sur la **clé primaire**  basée sur le mois d'observation.
{% enddocs %}

 
### 08_transfo_evenements_entreprise
{% docs doc_08_transfo_evenements_entreprise %}
Événements internes structurants de l'entreprise (ex: fusion, acquisition, changement de politique).
{% enddocs %}

{% docs cle_08_transfo_evenements_entreprise %}
Test sur la **clé primaire** qui est la date de l'événement
{% enddocs %}

 
### 09_transfo_evenements_historiques
{% docs doc_09_transfo_evenements_historiques %}
Impacts agrégés des événements historiques sur le moral/turnover.
{% enddocs %}

{% docs cle_09_transfo_evenements_historiques %}
Test sur la **clé primaire** qui est la date de l'événement historique
{% enddocs %}

 
### 10_Count_doublons
{% docs doc_10_Count_doublons %}
Historique des promotions, mobilités et évolutions salariales.
{% enddocs %}

{% docs cle_10_Count_doublons %}
Test sur la **clé primaire** qui est l'id de l'employé : un employé ne peut avoir qu'un ID et un ID ne peut être attribué qu'à un employé unique
{% enddocs %}

 
### 11_Calcul_mois_embauche
{% docs doc_11_Calcul_mois_embauche %}
Historique des promotions, mobilités et évolutions salariales.
{% enddocs %}

{% docs cle_11_Calcul_mois_embauche %}
Test sur la **clé primaire** qui est l'id de l'employé : un employé ne peut avoir qu'un ID et un ID ne peut être attribué qu'à un employé unique
{% enddocs %}

 


## Intermediate








## Marts
