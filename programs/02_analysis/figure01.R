library(sf)
library(dplyr)
library(ggplot2)
library(patchwork)
library(scales)

# ------------------------------------------------------------
# Figure 1: Average wildfire exposure, 2017–2024
# ------------------------------------------------------------

# ------------------------------------------------------------
# 1. Load data
# ------------------------------------------------------------

panel <- readRDS(
  "data/data_for_analysis/final_panel.rds"
)

districts <- readRDS(
  "data/data_for_analysis/school_district_boundaries.rds"
)

# ------------------------------------------------------------
# 2. Check data
# ------------------------------------------------------------

stopifnot(nrow(panel) == 944)
stopifnot(nrow(districts) == 59)

# ------------------------------------------------------------
# 3. Create one average observation per district, 2017–2024
# ------------------------------------------------------------

exposure_2017_2024 <- panel %>%
  distinct(
    SCHOOL_DISTRICT_NUMBER,
    year,
    pm25,
    burned_ha
  ) %>%
  group_by(
    SCHOOL_DISTRICT_NUMBER
  ) %>%
  summarise(
    avg_pm25 = mean(pm25, na.rm = TRUE),
    avg_burned_ha = mean(burned_ha, na.rm = TRUE),
    .groups = "drop"
  )

stopifnot(nrow(exposure_2017_2024) == 59)

# ------------------------------------------------------------
# 4. Join exposure data to district boundaries
# ------------------------------------------------------------

map_data <- districts %>%
  left_join(
    exposure_2017_2024,
    by = "SCHOOL_DISTRICT_NUMBER"
  )

stopifnot(sum(is.na(map_data$avg_pm25)) == 0)
stopifnot(sum(is.na(map_data$avg_burned_ha)) == 0)

# ------------------------------------------------------------
# 5. Panel A: Average PM2.5 exposure
# ------------------------------------------------------------

map_pm25 <- ggplot(map_data) +
  geom_sf(
    aes(fill = avg_pm25),
    color = "white",
    linewidth = 0.25
  ) +
  scale_fill_gradient(
    low = "#edf8fb",
    high = "#006d77",
    breaks = pretty_breaks(n = 5),
    name = expression(
      PM[2.5] ~ "(" * mu * "g/m"^3 * ")"
    ),
    guide = guide_colorbar(
      title.position = "top",
      title.hjust = 0.5,
      barwidth = unit(5.2, "cm"),
      barheight = unit(0.45, "cm"),
      ticks = TRUE,
      frame.colour = "grey70"
    )
  ) +
  labs(
    title = "A. Wildfire-Season PM₂.₅",
    subtitle = "Average May–September Concentration"
  ) +
  coord_sf(
    datum = NA,
    expand = FALSE
  ) +
  theme_void() +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 11,
      margin = margin(b = 2)
    ),
    plot.subtitle = element_text(
      size = 9,
      margin = margin(b = 10)
    ),
    legend.position = "bottom",
    legend.direction = "horizontal",
    legend.title = element_text(
      size = 9,
      margin = margin(b = 3)
    ),
    legend.text = element_text(size = 8),
    legend.margin = margin(t = 6, b = 0),
    plot.margin = margin(
      t = 4,
      r = 1,
      b = 2,
      l = 1
    )
  )

# ------------------------------------------------------------
# 6. Panel B: Average May–September burned area
# ------------------------------------------------------------

map_burned <- ggplot(map_data) +
  geom_sf(
    aes(fill = avg_burned_ha),
    color = "white",
    linewidth = 0.25
  ) +
  scale_fill_gradient(
    low = "#edf8fb",
    high = "#006d77",
    trans = "sqrt",
    breaks = c(
      0,
      25000,
      50000,
      100000,
      200000
    ),
    labels = label_number(
      scale_cut = cut_short_scale()
    ),
    name = "Burned Area (ha)",
    guide = guide_colorbar(
      title.position = "top",
      title.hjust = 0.5,
      barwidth = unit(5.2, "cm"),
      barheight = unit(0.45, "cm"),
      ticks = TRUE,
      frame.colour = "grey70"
    )
  ) +
  labs(
    title = "B. Nearby Wildfire Activity",
    subtitle = "Average May–September Burned Area"
  ) +
  coord_sf(
    datum = NA,
    expand = FALSE
  ) +
  theme_void() +
  theme(
    plot.title = element_text(
      face = "bold",
      size = 11,
      margin = margin(b = 2)
    ),
    plot.subtitle = element_text(
      size = 9,
      margin = margin(b = 10)
    ),
    legend.position = "bottom",
    legend.direction = "horizontal",
    legend.title = element_text(
      size = 9,
      margin = margin(b = 3)
    ),
    legend.text = element_text(size = 8),
    legend.margin = margin(t = 6, b = 0),
    plot.margin = margin(
      t = 4,
      r = 1,
      b = 1,
      l = 6
    )
  )

# ------------------------------------------------------------
# 7. Combine maps
# ------------------------------------------------------------

figure1 <- map_pm25 + map_burned +
  plot_layout(
    ncol = 2,
    widths = c(1, 1)
  ) +
  plot_annotation(
    theme = theme(
      panel.spacing = unit(0.2, "cm")
    )
  )

figure1 <- map_pm25|map_burned


# ------------------------------------------------------------
# 8. Display figure
# ------------------------------------------------------------

print(figure1)

# ------------------------------------------------------------
# 9. Save figure
# ------------------------------------------------------------

ggsave(
  "results/figure01_exposure_maps_2017_2024.png",
  plot = figure1,
  width = 13,
  height = 5.2,
  dpi = 300,
  bg = "white"
)