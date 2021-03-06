# Sets the following variables

# GLM_INCLUDE_DIRS - include directories for GLM
# GLM_LIBRARIES - libraries to link against GLM
# GLM_FOUND - true if GLM has been found and can be used

SET(GLM_FOUND "NO")

# default search dirs
SET(_glm_HEADER_SEARCH_DIRS
    "${CMAKE_CURRENT_SOURCE_DIR}/deps/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/deps/glm"
    "/usr/include"
    "/usr/local/include"
    )

# check environment variable
SET(_glm_ENV_ROOT_DIR "$ENV{GLM_ROOT_DIR}")

# set GLM ROOT if needed
IF(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)
    SET(GLM_ROOT_DIR "${_glm_ENV_ROOT_DIR}")
ENDIF(NOT GLM_ROOT_DIR AND _glm_ENV_ROOT_DIR)

IF(GLM_ROOT_DIR)
    SET(_glm_HEADER_SEARCH_DIRS "${GLM_ROOT_DIR}"
                                "${GLM_ROOT_DIR}/include"
                                 ${_glm_HEADER_SEARCH_DIRS})
ENDIF(GLM_ROOT_DIR)

FIND_PATH(GLM_INCLUDE_DIR "glm/glm.hpp"
    PATHS ${_glm_HEADER_SEARCH_DIRS})

message(STATUS "glm.hpp: ${GLM_INCLUDE_DIR}")

IF (GLM_INCLUDE_PATH AND GLM_LIBRARY)
    SET(GLM_LIBRARIES ${GLM_LIBRARY})
    SET(GLM_FOUND "YES")
ENDIF (GLM_INCLUDE_PATH AND GLM_LIBRARY)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GLM DEFAULT_MSG
    GLM_INCLUDE_DIR)

IF(NOT GLM_FOUND)
    # add external here
    set(GLM_INCLUDEDIR "${VENDOR_PREFIX}/src/glm" CACHE PATH "" FORCE)
    # set(GLM_INCLUDEDIR "${CMAKE_CURRENT_SOURCE_DIR}/deps/glm")
    list(APPEND vendor_args
        "-DGLM_INCLUDEDIR:PATH=${GLM_INCLUDEDIR}")
    INCLUDE(ExternalProject)
    ExternalProject_Add(glm
        PREFIX ${VENDOR_PREFIX}
        GIT_REPOSITORY https://github.com/RegrowthStudios/glm
        GIT_TAG 682979ddd8
        INSTALL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/deps/glm"
        # UPDATE_COMMAND ""
        # CONFIGURE_COMMAND ""
        # BUILD_IN_SOURCE 1
        # BUILD_COMMAND ""
        # INSTALL_COMMAND ""
        LOG_DOWNLOAD ON
        LOG_INSTALL ON
    )
    ExternalProject_Get_Property(glm source_dir)
    set(GLM_INCLUDE_DIR ${source_dir}/glm)
ENDIF(NOT GLM_FOUND)

IF(GLM_FOUND)
    SET(GLM_INCLUDE_DIRS "${GLM_INCLUDE_DIR}")
    MESSAGE(STATUS "GLM_INCLUDE_DIR = ${GLM_INCLUDE_DIR}")
ENDIF(GLM_FOUND)
