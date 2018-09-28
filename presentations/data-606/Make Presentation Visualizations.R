library(ggplot2)

sigma1 <- function(x) {
  y <- dnorm(x)
  y[x < -1 | x > 1] <- NA
  return(y)
}

sigma2 <- function(x) {
  y <- dnorm(x)
  y[x < -2 | x > 2] <- NA
  return(y)
}

sigma3 <- function(x) {
  y <- dnorm(x)
  y[x < -3 | x > 3] <- NA
  return(y)
}
# ggplot() with dummy data
ggplot(data.frame(x=c(-3.5, 3.5)), aes(x = x)) +
  stat_function(fun = sigma1, geom = "area", fill = "#6f9d9f", n = 500) +
  stat_function(fun = dnorm) + 
  #ggtitle('68%') +
  geom_vline(xintercept=0, linetype="dotted") +
  geom_vline(xintercept=1, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-1, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=2, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-2, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=3, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-3, linetype="dotted", color="#bd5532") +
  labs(x = "", y = "") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_blank(),
        plot.title = element_text(hjust = 0.5, colour = "#d7191c"), axis.title.x=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.x=element_blank(), axis.ticks.y=element_blank())

ggplot(data.frame(x=c(-3.5, 3.5)), aes(x = x)) +
  stat_function(fun = sigma2, geom = "area", fill = "#6f9d9f", n = 500) +
  stat_function(fun = dnorm) + 
  #ggtitle('68%') +
  geom_vline(xintercept=0, linetype="dotted") +
  geom_vline(xintercept=1, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-1, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=2, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-2, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=3, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-3, linetype="dotted", color="#bd5532") +
  
  labs(x = "", y = "") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_blank(),
        plot.title = element_text(hjust = 0.5, colour = "#ffffbf"), axis.title.x=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.x=element_blank(), axis.ticks.y=element_blank())

ggplot(data.frame(x=c(-3.5, 3.5)), aes(x = x)) +
  stat_function(fun = sigma3, geom = "area", fill = "#6f9d9f", n = 500) +
  stat_function(fun = dnorm) + 
  #ggtitle('68%') +
  geom_vline(xintercept=0, linetype="dotted") +
  geom_vline(xintercept=1, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-1, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=2, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-2, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=3, linetype="dotted", color="#bd5532") +
  geom_vline(xintercept=-3, linetype="dotted", color="#bd5532") +
  labs(x = "", y = "") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_blank(),
        plot.title = element_text(hjust = 0.5, colour = "#2c7bb6"), axis.title.x=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(),
        axis.ticks.x=element_blank(), axis.ticks.y=element_blank())