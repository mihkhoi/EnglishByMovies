# Tutorial
git clone https://github.com/<username>/EnglishByMovies.git
cd EnglishByMovies

# chạy SQL Server (docker), rồi:
cd server
dotnet restore .\EnglishByMovies.sln
dotnet ef database update -p .\src\Infrastructure\Infrastructure.csproj -s .\src\Api\Api.csproj
dotnet run --project .\src\Api\Api.csproj

cd ..\app\english_by_movies
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5080
