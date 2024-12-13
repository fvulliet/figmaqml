cmake_minimum_required(VERSION 3.16)

project(figmaqml VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appfigmaqml
    main.cpp
    figmaapimanager.hpp figmaapimanager.cpp
    figmadocument.hpp figmadocument.cpp
    figmanode.hpp figmanode.cpp
)

qt_add_qml_module(appfigmaqml
    URI figmaqml
    VERSION 1.0
    QML_FILES
        Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appfigmaqml PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appfigmaqml
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appfigmaqml
    PRIVATE
    Qt6::Quick
    Qt6::Network
    Qt6::Qml
)

include(GNUInstallDirs)
install(TARGETS appfigmaqml
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
