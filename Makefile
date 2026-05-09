
CC              = cc -g
RM              = rm -rf
CFLAGS          = -Wall -Wextra -Werror
MLXFLAGS        = -L./libs/minilibx-linux -lmlx -L/usr/lib -lm -lXext -lX11
NAME            = cub3D
INC             = -I./include
LIBFT           = libs/libft/libft.a
MLX             = libs/minilibx-linux/libmlx.a
GENERAL         = main.c
PARSING = \
                args_validation.c \
                errors.c \
                errors_2.c \
                scene_check.c \
                scene_check2.c \
                parsing_utils.c \
                parsing_utils2.c \
                parsing_utils3.c \
                parsing_utils4.c \
                parsing_utils5.c \
                parsing_utils6.c 
EXECUTOR        = init.c \
                  init_2.c \
                  init_3.c \
                  dda.c \
                  movement.c \
                  movement2.c \
                  player.c \
                  raycasting.c \
                  render.c \
                  render_utils.c
# _______________________________________________________________
#|___________________________[SRC FILES]_________________________|
#|_______________________________________________________________|
SRC             = $(GENERAL)\
$(PARSING)\
$(EXECUTOR)
VPATH           = src\
                    src/parsing\
                    src/parsing/map\
                    src/utils\
                    src/executor\
                    src/executor/app\
                    src/executor/map\
                    src/executor/utils
OBJ_DIR         = obj
OBJ             = $(SRC:%.c=$(OBJ_DIR)/%.o)
# _______________________________________________________________
#|_____________________________[RULES]___________________________|
#|_______________________________________________________________|
all:            $(NAME)
$(OBJ_DIR):
	mkdir -p obj
$(OBJ_DIR)/%.o: %.c
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) $(INC) -c $< -o $@
$(NAME): $(OBJ_DIR) $(OBJ) $(MLX) $(LIBFT)
	@echo "Linking $(NAME)..."
	@$(CC) $(CFLAGS) $(OBJ) $(LIBFT) $(MLXFLAGS) -o $(NAME)
	@echo "Build complete"
$(LIBFT): libs/libft/*.c
	@echo "Building libft..."
	@$(MAKE) -C libs/libft > /dev/null
$(MLX):
	@echo "Building MiniLibX..."
	@$(MAKE) -C ./libs/minilibx-linux > /dev/null
clean:
	@echo "Cleaning object files..."
	@$(RM) $(OBJ_DIR)
fclean: clean
	@echo "Cleaning executable and libraries..."
	@$(RM) $(NAME)
	@$(RM) $(LIBFT)
re:             fclean all
valgrind:
	@valgrind --leak-check=full -s --show-leak-kinds=all --track-fds=yes ./$(NAME) maps/valid_2.cub
gdb:
	gdb -tui ./$(NAME)
.PHONY:         all clean fclean re valgrind gdb