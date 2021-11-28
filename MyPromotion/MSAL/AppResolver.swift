//
//  AppResolver.swift
//  Demo
//
//  Created by 朱駿璽 on 2021/10/23.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { MSAuthState() }.scope(.application)
        register { MSAuthAdapter() }.scope(.application)
    }
}

func resolve<TService>() -> TService {
    return Resolver.resolve()
}
