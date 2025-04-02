# LogoSearch_flutter
Redux 與 Flutter 連動的練習專案，使用 [Logo.dev](https://www.logo.dev) 作為資料來源。

## Redux 架構

### Store

Redux 的架構核心，處理 Action 傳遞給 Reducer 的資料流，並且持有 state。

### State

資料保存的地方，透過 Store 來管理，View 使用 combine 來訂閱 state 的變化，
它是一個統一的資料來源，讓所有 View 可以取得最新的資料。

### Action

用來描述發生了什麼事情，透過 Store.dispatch 來發送 Action，並且透過 Reducer 來更新 state。

### Middleware

處理 Action 的請求，如：api、log、錯誤處理等。

### Reducer

處理 Action 的結果，並且更新 state。

## Redux 資料流

```mermaid
flowchart TB
    A["Store.dispatch(action)"] -->|送 Action 到第一個 Middleware| Middleware

    subgraph Middleware

        direction TB
        C{是否該處理
         Action}

        C -->|是| D[處理 Action]
        D -->|建立結果的 Action| E
        
        C -->|否| E[下一個 Middleware]
    end
    
    E -->|無下個 Middleware| F[Reducer]
    F -->|更新 State 資訊| G[Store.State]

```

## 架構圖

```mermaid
flowchart TD
    %% Flutter UI Layer
    subgraph "Flutter UI Layer"
        mainUI("Main (Flutter)"):::flutter
        searchPage("Search Logo Page"):::flutter
        detailPage("Logo Detail Page"):::flutter
    end

    %% Redux Layer
    subgraph "Redux Layer"
        ReduxAction("Redux Action"):::redux
        subgraph "Store Components"
            ReduxStore("Redux Store"):::redux
            LogoSearchStore("Redux Store (Logo Search)"):::redux
        end
        ReduxState("Redux State"):::redux
        subgraph "Redux Middleware"
            APIMiddleware("API Middleware"):::middleware
            ErrorMiddleware("Error Middleware"):::middleware
            ImageLoaderMiddleware("Image Loader Middleware"):::middleware
        end
        ReduxReducer("Redux Reducer"):::redux
    end

    %% Data/API Layer
    subgraph "Data/API Layer"
        APIHandler("API Handler"):::api
        BrandSearchRequest("Brand Search Request"):::api
        BrandSearchResponse("Brand Search Response"):::api
    end

    %% Platform-Specific Adapters
    subgraph "Platform-Specific Adapters"
        Android("Android"):::platform
        iOS("iOS"):::platform
        Linux("Linux"):::platform
        macOS("macOS"):::platform
        Windows("Windows"):::platform
        Web("Web"):::platform
    end

    %% Connections: UI dispatches actions to Redux
    searchPage -->|"dispatch(action)"| ReduxAction
    detailPage -->|"dispatch(action)"| ReduxAction
    mainUI -->|"dispatch(action)"| ReduxAction

    %% Redux Action sends to Store Components
    ReduxAction -->|"Store.dispatch(action)"| ReduxStore
    ReduxAction -->|"Store.dispatch(action)"| LogoSearchStore
    ReduxStore ---|"merge"| LogoSearchStore

    %% Store triggers Middleware processing
    ReduxStore -->|"triggerMiddleware"| APIMiddleware
    ReduxStore -->|"triggerMiddleware"| ErrorMiddleware
    ReduxStore -->|"triggerMiddleware"| ImageLoaderMiddleware

    %% Middleware processes and forwards to Reducer
    APIMiddleware -->|"process&forward"| ReduxReducer
    ErrorMiddleware -->|"process&forward"| ReduxReducer
    ImageLoaderMiddleware -->|"process&forward"| ReduxReducer

    %% API Middleware interacts with external API
    APIMiddleware -->|"API_Call"| APIHandler
    APIHandler -->|"API_Response"| APIMiddleware

    %% APIHandler works with data models
    BrandSearchRequest -->|"formRequest"| APIHandler
    APIHandler -->|"parseResponse"| BrandSearchResponse

    %% Reducer updates state which notifies UI
    ReduxReducer -->|"updateState"| ReduxState
    ReduxState -->|"notifyUI"| mainUI
    ReduxState -->|"notifyUI"| searchPage
    ReduxState -->|"notifyUI"| detailPage

    %% Click Events
    click mainUI "https://github.com/darktt/logosearch_flutter/blob/main/lib/main.dart"
    click searchPage "https://github.com/darktt/logosearch_flutter/blob/main/lib/search_logo_page/search_logo_page.dart"
    click detailPage "https://github.com/darktt/logosearch_flutter/blob/main/lib/logo_detail_page/logo_detail_page.dart"
    click ReduxStore "https://github.com/darktt/logosearch_flutter/blob/main/lib/redux/store.dart"
    click LogoSearchStore "https://github.com/darktt/logosearch_flutter/blob/main/lib/view_model/logo_search_store.dart"
    click ReduxState "https://github.com/darktt/logosearch_flutter/blob/main/lib/view_model/logo_search_state.dart"
    click ReduxAction "https://github.com/darktt/logosearch_flutter/blob/main/lib/view_model/logo_search_action.dart"
    click APIMiddleware "https://github.com/darktt/logosearch_flutter/blob/main/lib/view_model/api_middleware.dart"
    click ErrorMiddleware "https://github.com/darktt/logosearch_flutter/blob/main/lib/view_model/error_middleware.dart"
    click ImageLoaderMiddleware "https://github.com/darktt/logosearch_flutter/blob/main/lib/view_model/image_loader_middleware.dart"
    click APIHandler "https://github.com/darktt/logosearch_flutter/blob/main/lib/models/api_handler.dart"
    click BrandSearchRequest "https://github.com/darktt/logosearch_flutter/blob/main/lib/models/brand_search_request.dart"
    click BrandSearchResponse "https://github.com/darktt/logosearch_flutter/blob/main/lib/models/brand_search_response.dart"
    click Android "https://github.com/darktt/logosearch_flutter/tree/main/android"
    click iOS "https://github.com/darktt/logosearch_flutter/tree/main/ios"
    click Linux "https://github.com/darktt/logosearch_flutter/tree/main/linux"
    click macOS "https://github.com/darktt/logosearch_flutter/tree/main/macos"
    click Windows "https://github.com/darktt/logosearch_flutter/tree/main/windows"
    click Web "https://github.com/darktt/logosearch_flutter/tree/main/web"

    %% Styles
    classDef flutter fill:#ccf,stroke:#333,stroke-width:2px;
    classDef redux fill:#fcf,stroke:#333,stroke-width:2px;
    classDef middleware fill:#cfc,stroke:#333,stroke-width:2px;
    classDef api fill:#ffc,stroke:#333,stroke-width:2px;
    classDef platform fill:#cff,stroke:#333,stroke-width:2px;
```