#!/bin/bash

function cleanUp(){
	rm -rf starter-expo-stack
}
function createEnv(){
	[ -e file ] && rm .env
	printf "# Supabase" > .env
	printf "EXPO_PUBLIC_SUPABASE_URL=https://{projectUrl}.supabase.co" >> .env
	printf "EXPO_PUBLIC_SUPABASE_ANON_KEY={anonKey}" >> .env
}
function downloadPrettierConfig(){
	git clone https://github.com/artiphishle/prettierrc &>/dev/null
	mv prettierrc/.prettierrc .
	rm -rf prettierrc
}
function log(){
	echo $1 >> ./logs/setup.log
}
function printSuccess(){
	echo "✅ ${1}"
}
function printTitle(){
	printf '\n\n'
	echo "🚀 ${1}"
	printf '\n'
}

printTitle 'starter-expo-stack v1.0.0'

# Clean up
cleanUp && printSuccess "Clean up"

# Download package
# npx create-expo-stack@latest starter-expo-stack-gen --expo-router --drawer+tabs --nativewind --supabase --yarn &>/dev/null
git clone --depth 1 --branch 'v1.0.0' git@github.com:artiphishle/starter-expo-stack $pkg &>/dev/null && printSuccess "Package 'starter-expo-stack' downloaded"

# Install package
cd starter-expo-stack && yarn &>/dev/null && printSuccess "Package 'starter-expo-stack' installed"

# Download .prettierrc & run ESLint & Prettier
# downloadPrettierConfig && printSuccess "Download .prettierrc"
yarn run format &>/dev/null && printSuccess "Checked ESLint & Prettier"

# Upgrade Packages
# ncu && ncu -u
# yarn add \
	# react-native-gesture-handler@2.14.0 \
	# react-native-reanimated@3.6.2

# Run
yarn start

exit 0
