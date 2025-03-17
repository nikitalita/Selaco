vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO zdoom/zmusic
        REF 6928b8609db9b1c104c4cd4f9b163486121fb0f0
        SHA512 ced8ae3e2491b06cbe5e34f5b0674187f67d1ff3afbc1492c446c30a81c7552c3e464ff555a873ba50f35f0ff7118d74a441cd7b36ccc69081903647102e121e
        HEAD_REF main
        PATCHES
        fix-sndfile.patch
        fix-util.patch
        add-glib-vcpkg.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
        FEATURES
        vcpkg-libsndfile VCPKG_LIBSNDFILE
)

# if VCPKG_LIBSNDFILE is enabled, we need to set DYN_SNDFILE to OFF
if (VCPKG_LIBSNDFILE)
    set(DYN_SNDFILE OFF)
endif()

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
        -DDYN_SNDFILE=${DYN_SNDFILE}
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME zmusic CONFIG_PATH lib/cmake/zmusic)
file(
        INSTALL "${SOURCE_PATH}/licenses/zmusic.txt"
        DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
        RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
