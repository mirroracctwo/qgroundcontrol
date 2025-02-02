message(STATUS "Creating Mac DMG")

set(STAGING_BUNDLE_PATH ${CMAKE_BINARY_DIR}/staging/${TARGET_APP_NAME}.app)

execute_process(
    COMMAND codesign --force --deep -s - "${STAGING_BUNDLE_PATH}"
    COMMAND_ERROR_IS_FATAL ANY
)

file(REMOVE_RECURSE ${CMAKE_BINARY_DIR}/package)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/package)
file(COPY ${STAGING_BUNDLE_PATH} DESTINATION ${CMAKE_BINARY_DIR}/package)

execute_process(
    COMMAND create-dmg --volname "${TARGET_APP_NAME}" --filesystem "APFS" "${TARGET_APP_NAME}.dmg" "${CMAKE_BINARY_DIR}/package/"
    COMMAND_ERROR_IS_FATAL ANY
)
