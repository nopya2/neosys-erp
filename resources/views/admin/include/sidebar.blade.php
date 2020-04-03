<div class="app-sidebar sidebar-shadow">
    <div class="app-header__logo">
        <div class="logo-src"></div>
        <div class="header__pane ml-auto">
            <div>
                <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                    <span class="hamburger-box">
                        <span class="hamburger-inner"></span>
                    </span>
                </button>
            </div>
        </div>
    </div>
    <div class="app-header__mobile-menu">
        <div>
            <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                <span class="hamburger-box">
                    <span class="hamburger-inner"></span>
                </span>
            </button>
        </div>
    </div>
    <div class="app-header__menu">
        <span>
            <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                <span class="btn-icon-wrapper">
                    <i class="fa fa-ellipsis-v fa-w-6"></i>
                </span>
            </button>
        </span>
    </div>
    <div class="scrollbar-sidebar">
        <div class="app-sidebar__inner">
            <ul class="vertical-nav-menu">
                {{--<li class="app-sidebar__heading">Dashboards</li>--}}
                {{--<li>--}}
                    {{--<a href="index.html" class="mm-active">--}}
                        {{--<i class="metismenu-icon pe-7s-rocket"></i>--}}
                        {{--Tableau de bord--}}
                    {{--</a>--}}
                {{--</li>--}}
                <li class="app-sidebar__heading">Menu Général</li>
                {{-- Customers --}}
                <li class="@isset($page) {{ ($page == 'customer') ? 'mm-active' : '' }} @endisset">
                    <a href="#">
                        <i class="metismenu-icon fa fa-address-book"></i>
                        Clients
                        <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                    </a>
                    <ul>
                        <li>
                            <a href="{{ route('customer.index') }}" class="@isset($sub_page) {{ ($sub_page == 'customer.list') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon"></i>
                                Liste
                            </a>
                        </li>
                        <li>
                            <a href="{{ route('customer.create') }}" class="@isset($sub_page) {{ ($sub_page == 'customer.create') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon">
                                </i>Ajouter
                            </a>
                        </li>
                    </ul>
                </li>
                {{--  Quotes and invoices --}}
                <li class="@isset($page) {{ ($page == 'quote' || $page == 'invoice' || $page == 'credit_note') ? 'mm-active' : '' }} @endisset">
                    <a href="#">
                        <i class="metismenu-icon fa fa-address-book"></i>
                        Devis et Factures
                        <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                    </a>
                    <ul>
                        <li>
                            <a href="{{ route('quote.index') }}" class="@isset($sub_page) {{ ($sub_page == 'quote.list') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon"></i>
                                Devis
                            </a>
                        </li>
                        <li>
                            <a href="{{ route('invoice.index') }}" class="@isset($sub_page) {{ ($sub_page == 'invoice.list') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon">
                                </i>Factures
                            </a>
                        </li>
                        <li>
                            <a href="{{ route('credit_note.index') }}" class="@isset($sub_page) {{ ($sub_page == 'credit_note.list') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon">
                                </i>Factures d'avoir
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="app-sidebar__heading">Administration</li>
                {{-- Users --}}
                <li class="@isset($page) {{ ($page == 'user') ? 'mm-active' : '' }} @endisset">
                    <a href="#">
                        <i class="metismenu-icon pe-7s-users"></i>
                        Utilisateurs
                        <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                    </a>
                    <ul>
                        <li>
                            <a href="{{ route('user.index') }}" class="@isset($sub_page) {{ ($sub_page == 'user.list') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon"></i>
                                Liste
                            </a>
                        </li>
                        <li>
                            <a href="{{ route('user.create') }}" class="@isset($sub_page) {{ ($sub_page == 'user.create') ? 'mm-active' : '' }} @endisset">
                                <i class="metismenu-icon">
                                </i>Ajouter
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="{{ route('tax.index') }}" class="@isset($page) {{ ($page == 'tax') ? 'mm-active' : '' }} @endisset">
                        <i class="metismenu-icon pe-7s-diamond"></i>
                        Taxes
                    </a>
                </li>
                <li>
                    <a href="{{ route('information') }}" class="@isset($page) {{ ($page == 'information') ? 'mm-active' : '' }} @endisset">
                        <i class="metismenu-icon pe-7s-info"></i>
                        Informations
                    </a>
                </li>
                <li>
                    <a href="{{ route('parameters') }}" class="@isset($page) {{ ($page == 'parameters') ? 'mm-active' : '' }} @endisset">
                        <i class="metismenu-icon pe-7s-settings"></i>
                        Paramètres
                    </a>
                </li>

            </ul>
        </div>
    </div>
</div>