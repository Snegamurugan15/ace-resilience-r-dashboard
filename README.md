# ACE Resilience R Dashboard

This repository contains an R/Shiny portfolio version of an M.Sc project on Adverse Childhood Experiences, resilience, and related classification modeling.

The project has been cleaned for public GitHub use: raw individual-response spreadsheets are excluded, while the dashboard code, modeling workflow, trained `.rds` artifacts, and presentation/report materials are preserved.

## What It Demonstrates

- R Shiny dashboard development
- ACE/CER response scoring
- Random Forest and SVM model usage through saved `.rds` artifacts
- R-based model retraining workflow
- Research-project documentation and reproducible public packaging

## Repository Structure

```text
app/app.R                         # Clean Shiny dashboard
R/score_ace.R                     # Scoring helper
R/train_models.R                  # Example RF/SVM training workflow
data/sample_ace_cer_responses.csv # Synthetic sample data
models/*.rds                      # Saved project model artifacts
docs/                             # Presentation and selected methodology material
legacy/                           # Original R scripts preserved for reference
```

## Run the Dashboard

```r
source("requirements.R")
shiny::runApp("app")
```

## Retrain Example Models

```r
source("requirements.R")
source("R/train_models.R")
```

## Related Publication

This project is connected to the publication:

[Exploring the Impact of Early Trauma on Emotional Regulation and Mental Well-Being Among College Students](https://www.igi-global.com/chapter/exploring-the-impact-of-early-trauma-on-emotional-regulation-and-mental-well-being-among-college-students/351175)

## Public Data Note

The original folder contains research spreadsheets and survey-related materials. Those files are not published here to avoid exposing individual response data. The included CSV is synthetic and only supports demo/retraining workflow checks.

## Disclaimer

This is an academic/research analytics project. It should not be used as a clinical, diagnostic, legal, or counseling instrument.
