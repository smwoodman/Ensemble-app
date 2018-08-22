### Reactive functions that return display tables for various tabs
# Most tables use 'if... return()' rather than 'req()' so that
# subsequent reactive functions won't be stopped


###############################################################################
### Table of original models
table_orig <- reactive({
  if (length(vals$models.ll) == 0) return()

  data.frame(vals$models.names, t(as.data.frame(vals$models.data.names)),
             ifelse(vals$models.pred.type == "1", "Absolute", "Relative"),
             stringsAsFactors = FALSE,
             row.names = paste("Original", 1:length(vals$models.names))) %>%
    purrr::set_names(
      c("SDM filename", "Predictions", "Weights", "Prediction type")
    )
})


###############################################################################
### Table of original models with stats
table_orig_stats <- reactive({
  req(table_orig())

  data.frame(vals$models.names, t(as.data.frame(vals$models.specs)),
             stringsAsFactors = FALSE,
             row.names = paste("Original", 1:length(vals$models.names))) %>%
    purrr::set_names(
      c("SDM filename", "Resolution", "Cell count", "Non-NA prediction count",
        "Abundance", "Long, lat range")
    )
})


###############################################################################
### Table of overlaid models
table_overlaid <- reactive({
  if (length(vals$overlaid.models) == 0) return()

  data.frame(t(as.data.frame(vals$overlaid.models.specs)),
             stringsAsFactors = FALSE,
             row.names = paste("Overlaid", seq_along(vals$overlaid.models))) %>%
    purrr::set_names(
      c("SDM filename", "Predictions", "Weights", "Prediction type",
        "Resolution", "Cell count", "Non-NA prediction count", "Abundance",
        "Long, lat range")
    )
})


###############################################################################
### Table of created ensemble models
table_ensembles <- reactive({
  if (length(vals$ensemble.models) == 0) return()

  data.frame(vals$ensemble.overlaid.idx, vals$ensemble.rescaling,
             vals$ensemble.method, vals$ensemble.weights,
             stringsAsFactors = FALSE,
             row.names = paste("Ensemble", 1:length(vals$ensemble.method))) %>%
    purrr::set_names(
      c("Overlaid predictions used", "Rescaling method", "Ensembling method",
        "Weights")
    )
})


###############################################################################
# Other are rendered in their pertinent files

###############################################################################