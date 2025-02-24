# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Forms Gen' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Add the Firebase pods
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseCrashlytics'
  
  # Add the pod for Firebase Cloud Messaging
  # pod 'Firebase/Messaging' # Uncomment this line to use FCM
  
  pod "KRProgressHUD"
  
  pod 'SideMenu'
  
  pod 'IQKeyboardManager'

  pod 'Kingfisher'
  
  pod 'GoogleSignIn'
  
  pod 'FacebookLogin'
  pod 'FacebookCore'
  pod 'FacebookShare'
  
  pod 'SwiftLint'
  
  # Pods for Forms Gen

  target 'Forms GenTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Forms GenUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
