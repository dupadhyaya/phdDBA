#survey ----------

library(tidyverse)
library(scales)

# Sample data (percentages for each Likert level, rows = questions)
data <- tribble(
  ~Statement, ~`1`, ~`2`, ~`3`, ~`4`, ~`5`,
  "I expect my university to increase the use of AI in teaching and learning", 4, 8, 29, 32, 27,
  "Universities should provide training for students on the effective use of AI tools", 3, 4, 21, 31, 41,
  "Universities should provide training for faculty on the effective use of AI tools", 2, 4, 21, 31, 42,
  "I expect my university to offer more courses on AI literacy", 3, 4, 21, 31, 41,
  "Universities should involve students in the decision-making process regarding which AI tools are implemented", 2, 4, 23, 33, 38
)

# Reshape to long format
data_long <- data %>%
  pivot_longer(cols = -Statement, names_to = "Likert", values_to = "Percent") %>%
  mutate(
    Likert = factor(Likert, levels = c("1", "2", "3", "4", "5")),
    Statement = fct_rev(factor(Statement))
  )

# Define Likert colors
likert_colors <- c("1" = "#d4dbe4", "2" = "#b2c1d1", "3" = "#4f8ad0", "4" = "#003cd2", "5" = "#14084e")

# Plot
ggplot(data_long, aes(x = Percent, y = Statement, fill = Likert)) +
  geom_col(position = "stack") +
  scale_fill_manual(values = likert_colors, name = "Response") +
  scale_x_continuous(labels = label_percent(scale = 1)) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.major.y = element_blank(),
    axis.title = element_blank(),
    legend.position = "top",
    legend.direction = "horizontal",
    legend.title = element_blank()
  ) +
  labs(title = "Student Expectations for AI in Universities")



#waffle plot--------
pacman::p_load(waffle, ggplot2, showtext)
font_add_google("Poppins", "poppins")
showtext_auto()

# Define the data
parts <- c("Using AI" = 86, "Not Using AI" = 14)

# Create waffle plot
?waffle
waffle(  parts,rows = 10, size = 1,  colors = c("#2B50F7", "#E5E7EB"), # Blue and Light Gray
  title = "Percentage of students using AI in their studies",
  xlab = "Each dot represents 1%"
) +  theme( plot.title = element_text(size = 12, face = "bold", hjust = 0.5),    plot.caption = element_text(size = 10, hjust = 0.5),    axis.title.x = element_text(size = 12, hjust = 0.5),
    legend.position = "none"   ) +  annotate("text", x = 5, y = 12, label = "86%", size = 10, fontface = "bold", color = "#2B50F7") +   annotate("text", x = 5, y = 11, label = "of students claim to use\nAI in their studies", size = 4.5)

# Create data for 100 grid points
df <- expand.grid(x = 1:10, y = 1:10) %>%
  arrange(desc(y), x) %>%             # Fill top to bottom, left to right
  mutate(status = ifelse(row_number() <= 86, "Using AI", "Not Using AI"))

# Plot
ggplot(df, aes(x = x, y = y, color = status)) +
  geom_point(size = 8, shape = 16) +  # Circle shape
  scale_color_manual(values = c("Using AI" = "#2B50F7", "Not Using AI" = "#E5E7EB")) +
  coord_equal() +
  theme_void() +
  theme(legend.position = "none") +
  annotate("text", x = 5.5, y = 11.5, label = "86%", size = 10, fontface = "bold", color = "#2B50F7") +
  annotate("text", x = 5.5, y = 10.3, label = "of students claim to use\nAI in their studies", size = 4.5) +
  labs(title = "Percentage of students using AI in their studies") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    plot.margin = margin(20, 20, 20, 20)
  )


#-------
library(ggforce)

# Define the data: three circles — outer (100%), middle (54%), inner (24%)
# Define circle data (plot smallest last to appear on top)
circles <- tribble(
  ~x0, ~y0, ~r, ~fill, ~label, ~label_y, ~text_color,
  0,   0,   1, "#E5E7EB", "", NA, NA, # Outer (gray background)
  0,   0, 0.54, "#2B50F7", "54%\nuse daily or weekly",  0.05, "white",
  0,   0, 0.24, "#14084e", "24%\nuse AI daily",         0,    "white"
)
circles
# Plot
ggplot() +
  # Circles (smallest last for layering)
  geom_circle(data = circles, aes(x0 = x0, y0 = y0, r = r, fill = fill), color = NA) +
  
  # Labels inside colored circles
  geom_text(data = filter(circles, label != ""), 
            aes(x = 0, y = label_y, label = label, color = text_color), 
            size = c(5, 4), fontface = "bold", lineheight = 1.1, show.legend = FALSE) +
  
  # Manual fill and text color
  scale_fill_identity() +
  scale_color_identity() +
  
  coord_fixed() +
  theme_void() +
  
  # Top text annotations
  annotate("text", x = 0, y = 1.45, label = "54%", size = 10, fontface = "bold", color = "#14084e") +
  annotate("text", x = 0, y = 1.2, label = "of students use AI at least\non a weekly basis", size = 4.5, color = "#14084e", lineheight = 1.2) +
  
  # Title
  labs(title = "Frequency of students using AI in their studies") +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    plot.margin = margin(20, 20, 20, 20)
  )
#----
# Load grid graphics
library(grid)
pacman::p_load(grid, Cairo)
# Export to a PDF file
CairoPDF("ai_usage_nested_circles.pdf", width = 6, height = 6)
# Start a new page
grid.newpage()

# Define circle positions and radii
outer_radius <- 0.5
middle_radius <- 0.35
inner_radius <- 0.2

# Draw outermost circle (100%)
grid.circle(x = 0.5, y = 0.5, r = outer_radius, gp = gpar(fill = "#E5E7EB", col = NA))

# Draw middle circle (54%)
grid.circle(x = 0.5, y = 0.5, r = middle_radius, gp = gpar(fill = "#2B50F7", col = NA))

# Draw innermost circle (24%)
grid.circle(x = 0.5, y = 0.5, r = inner_radius, gp = gpar(fill = "#14084e", col = NA))

# Add text inside the inner circle
grid.text("24%\nuse AI daily", x = 0.5, y = 0.5, gp = gpar(col = "white", fontsize = 12, fontface = "bold"))

# Add text inside the middle circle
grid.text("54%\nuse daily or weekly", x = 0.5, y = 0.66, gp = gpar(col = "white", fontsize = 10, fontface = "bold"))

# Top central bold text
grid.text("54%", x = 0.5, y = 0.92, gp = gpar(fontsize = 24, fontface = "bold", col = "#14084e"))

# Subtitle under 54%
grid.text("of students use AI at least\non a weekly basis", x = 0.5, y = 0.85, gp = gpar(fontsize = 10, col = "#14084e"))

# Title
grid.text("Frequency of students using AI in their studies", x = 0.5, y = 0.98,  gp = gpar(fontsize = 14, fontface = "bold"))
# Finish writing
dev.off()
browseURL("ai_usage_nested_circles.pdf")
#------

# Sample data (you can adjust sizes and positions as needed)
tools <- data.frame(
  tool = c("ChatGPT", "Grammarly", "Microsoft Copilot", "Google Gemini", "Perplexity", "Others"),
  usage = c(80, 45, 40, 35, 15, 10),  # Proportional sizes
  x = c(2, 4, 4, 2.5, 5.2, 3.5),
  y = c(2, 3.8, 2.1, 0.4, 2.9, 1.1),
  fill = c("#14084e", "#2B50F7", "#4F9DF7", "#A9C1FB", "#CCCCCC", "#999999"),
  text_color = c("white", "white", "white", "black", "black", "black")
)
tools
# Plot
ggplot(tools, aes(x = x, y = y)) +geom_point(aes(size = usage, fill = fill), shape = 21, color = NA) +geom_text(aes(label = tool, color = text_color), size = 4.5, fontface = "bold") +
  scale_size(range = c(10, 50), guide = "none") +
  scale_fill_identity() +
  scale_color_identity() +
  coord_fixed() +
  theme_void() +
  labs(title = "Most used AI tools by students") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

library(ggplot2)
library(ggforce)

# Define bubble data
ai_tools <- tibble::tibble( tool = c("ChatGPT", "Grammarly", "Microsoft Copilot", "Google Gemini", "Perplexity", "Others"),  r = c(1.5, 1.1, 1.05, 0.95, 0.45, 0.4)-.2,    x = c(2, 4.3, 4.1, 2.6, 5.2, 3.3) + .5,   y = c(2, 3.8, 2, 0.6, 2.9, 1.1),  fill = c("#14084e", "#2B50F7", "#4F9DF7", "#A9C1FB", "#CCCCCC", "#999999"),  text_color = c("white", "white", "white", "black", "black", "black"))

# Plot
ggplot(ai_tools) + geom_circle(aes(x0 = x, y0 = y, r = r, fill = fill), color = NA) +  geom_text(aes(x = x, y = y, label = tool, color = text_color), fontface = "bold", size = 4.5) + scale_fill_identity() +  scale_color_identity() +  coord_fixed() +  labs(title = "Most used AI tools by students") +  theme(  plot.title = element_text(hjust = 0.5, size = 16, face = "bold"), plot.margin = margin(10, 10, 10, 10) )


#----
library(grid)

# Create PDF or use grid.newpage() to draw directly
# pdf("ai_decision_feedback.pdf", width = 10, height = 6)
grid.newpage()

# Set circle positions
left_center <- c(0.3, 0.5)
right_center <- c(0.7, 0.5)

# Left circle (71%)
grid.circle(x = left_center[1], y = left_center[2], r = 0.15, gp = gpar(fill = "#14084e", col = NA))
grid.circle(x = left_center[1], y = left_center[2], r = 0.17, gp = gpar(fill = "#E5E7EB", col = NA))  # border effect
grid.circle(x = left_center[1], y = left_center[2], r = 0.15, gp = gpar(fill = "#14084e", col = NA))
grid.text("71%", x = left_center[1], y = left_center[2] + 0.03, gp = gpar(col = "white", fontsize = 16, fontface = "bold"))
grid.text("of students demand\ninvolvement\nin AI decision-making", x = left_center[1], y = left_center[2] - 0.05, 
          gp = gpar(col = "white", fontsize = 10), just = "center")

# Right circle (outer = 100%, inner = 34%)
grid.circle(x = right_center[1], y = right_center[2], r = 0.15, gp = gpar(fill = "#14084e", col = NA))
grid.circle(x = right_center[1], y = right_center[2], r = 0.08, gp = gpar(fill = "#2B50F7", col = NA))
grid.text("34%", x = right_center[1], y = right_center[2], gp = gpar(col = "white", fontsize = 14, fontface = "bold"))

# Side explanation text
grid.text("Only 34% of students demanding\nto be heard think that their university\nactively seeks feedback from them", 
          x = right_center[1] + 0.2, y = right_center[2], just = "left", 
          gp = gpar(col = "#14084e", fontsize = 10, lineheight = 1.3))

# Title and subtitles
grid.text("Students seek greater involvement in AI decisions, yet feel unheard", 
          x = 0.5, y = 0.95, gp = gpar(fontsize = 14, fontface = "bold", col = "#14084e"))

grid.text("Student expectations and perception of involvement in AI decision making", 
          x = 0.5, y = 0.91, gp = gpar(fontsize = 10, fontface = "bold"))

grid.text("● Universities should involve students in the decision-making process regarding which AI tools are implemented\n● My university actively seeks student feedback on the effectiveness of its AI tools", 
          x = 0.5, y = 0.875, gp = gpar(fontsize = 9), just = "center")

#--------
library(tidyverse)

# Function to generate waffle data
make_waffle_data <- function(pct, label, x_offset = 0) {
  grid <- expand.grid(x = 1:10, y = 1:10)
  grid <- grid %>%
    mutate(
      filled = row_number() <= pct,
      x = x + x_offset,
      label = label
    )
  return(grid)
}

# Generate waffle data for both percentages
waffle1 <- make_waffle_data(55, "Over-reliance decreases value", x_offset = 0)
waffle2 <- make_waffle_data(52, "Over-reliance affects performance", x_offset = 12)

# Combine
waffle_data <- bind_rows(waffle1, waffle2)
waffle_data
# Plot
ggplot(waffle_data, aes(x, y)) +
  geom_point(aes(color = filled), shape = 16, size = 4) +
  scale_color_manual(values = c("TRUE" = "#2B50F7", "FALSE" = "#E5E7EB")) +
  coord_equal() +
  facet_wrap(~label) +
  theme_void() +
  theme(
    strip.text = element_text(size = 12, face = "bold", hjust = 0.5),
    legend.position = "none"
  ) +
  annotate("text", x = 5.5, y = 11.5, label = "55%", data = waffle1, size = 8, fontface = "bold", color = "#14084e") +
  annotate("text", x = 5.5 + 12, y = 11.5, label = "52%", data = waffle2, size = 8, fontface = "bold", color = "#14084e") +
  annotate("text", x = 5.5, y = 10.7, label = "of students believe\nover-reliance on AI in teaching\ndecreases the value they receive", 
           data = waffle1, size = 3.5, color = "#14084e", lineheight = 1.2) +
  annotate("text", x = 5.5 + 12, y = 10.7, label = "of students believe\nover-reliance on AI negatively\nimpacts their academic performance", 
           data = waffle2, size = 3.5, color = "#14084e", lineheight = 1.2)


library(waffle)
library(ggplot2)
library(patchwork)

# Define each waffle chart
waffle1 <- waffle(c("Value Decreased" = 55, "Remaining" = 45),
                  rows = 10,
                  size = 0.5,
                  colors = c("#2B50F7", "#E5E7EB"),
                  title = "55%\nof students believe\nAI reduces teaching value") +
  theme(plot.title = element_text(size = 10, hjust = 0.5, face = "bold"))

waffle2 <- waffle(c("Performance Affected" = 52, "Remaining" = 48),
                  rows = 10,
                  size = 0.5,
                  colors = c("#2B50F7", "#E5E7EB"),
                  title = "52%\nof students believe\nAI hurts performance") +
  theme(plot.title = element_text(size = 10, hjust = 0.5, face = "bold"))

# Combine plots side by side
combined_plot <- waffle1 + waffle2

# Show
print(combined_plot)
#---
# Create waffle data
make_waffle <- function(pct, label, x_offset) {
  df <- expand.grid(x = 1:10, y = 1:10) %>%
    mutate(
      filled = row_number() <= pct,
      group = label,
      x = x + x_offset
    )
  return(df)
}

# Combine both
waffle_data <- bind_rows(
  make_waffle(55, "AI reduces value", 0),
  make_waffle(52, "AI impacts performance", 12)
)

# Plot
ggplot(waffle_data, aes(x, y, color = filled)) +
  geom_point(shape = 16, size = 4) +
  scale_color_manual(values = c("TRUE" = "#2B50F7", "FALSE" = "#E5E7EB")) +
  coord_fixed() +
  theme_void() +
  facet_wrap(~group) +
  theme(strip.text = element_text(face = "bold", size = 12))


data.frame(
  parts = factor(rep(month.abb[1:3], 3), levels=month.abb[1:3]),
  vals = c(100, 20, 30, 6, 14, 40, 30, 20, 10),
  fct = c(rep("Thing 1", 3), rep("Thing 2", 3), rep("Thing 3", 3))
) -> xdf
xdf
ggplot(xdf, aes(fill = parts, values = vals)) +  geom_waffle(n_rows=5, make_proportional = T, flip=T, radius=unit(10,'pt')) + geom_text(aes(x=fct, y=parts, label=vals)) + facet_wrap(~fct) + theme_void()
