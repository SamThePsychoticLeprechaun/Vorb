# Setup VORB Dependencies
macro(setup_dependencies)
  install_glm()
  # install_glew()
  install_sdl()
  # install_lodepng()
endmacro(setup_dependencies)

macro(install_glm)
    # GLM
    find_package(GLM)
    if (GLM_FOUND)
      add_definitions(-DTYPES_GLM)
      add_definitions(-Dglm_core_type_gentype2)
      add_definitions(-Dglm_core_type_gentype3)
      add_definitions(-Dglm_core_type_gentype4)
      add_definitions(-DGLM_GTC_quaternion)
      add_definitions(-Dglm_core_type_mat2x2)
      add_definitions(-Dglm_core_type_mat3x3)
      add_definitions(-Dglm_core_type_mat4x4)
      include_directories(SYSTEM ${GLM_INCLUDE_DIRS})
      link_directories(${GLM_LIBRARY_DIRS})
      add_definitions(${GLM_DEFINITIONS})

    endif (GLM_FOUND)
endmacro(install_glm)

macro(install_glew)
    # GLEW
    find_package(GLEW)
    if (GLEW_FOUND)
      include_directories(SYSTEM ${GLEW_INCLUDE_DIRS})
      link_directories(${GLEW_LIBRARY_DIRS})
      add_definitions(${GLEW_DEFINITIONS})
    endif (GLEW_FOUND)
endmacro(install_glew)

macro(install_sdl)
    # SDL
    set(SDL_BUILDING_LIBRARY True)
    find_package(SDL2)
    if (SDL2_FOUND)
      find_package(SDL2_ttf)
      if (SDL2_TTF_FOUND)
        include_directories(SYSTEM ${SDL2_TTF_INCLUDE_DIRS})
        link_directories(${SDL2_TTF_LIBRARY_DIRS})
        add_definitions(${SDL2_TTF_DEFINITIONS})
      endif (SDL2_TTF_FOUND)
      include_directories(SYSTEM ${SDL2_INCLUDE_DIRS})
      link_directories(${SDL2_LIBRARY_DIRS})
      add_definitions(${SD2L_DEFINITIONS})
    endif (SDL2_FOUND)
endmacro(install_sdl)

macro(install_lodepng)
    # LODE_PNG
    find_package(lodepng)
    if (LODE_PNG_FOUND)
      include_directories(SYSTEM ${LODE_PNG_INCLUDE_DIRS})
      link_directories(${LODE_PNG_LIBRARY_DIRS})
      add_definitions(${LODE_PNG_DEFINITIONS})
    endif (LODE_PNG_FOUND)
endmacro(install_lodepng)
