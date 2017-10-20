// Generated by RcppR6 (0.2.4): do not edit by hand
#ifndef _MASH_RCPPR6_PRE_HPP_
#define _MASH_RCPPR6_PRE_HPP_

#include <RcppCommon.h>


namespace MASH {
namespace RcppR6 {
template <typename T> class RcppR6;
}
}

namespace MASH { class HumanEventQ; }
namespace MASH { class HistoryGeneric; }
namespace MASH { class HistoryTravel; }
namespace MASH { class humanPfSI; }
namespace MASH { class mosquitoPfSI; }
namespace MASH { class humanPfMOI; }
namespace MASH { class mosquitoPfMOI; }
namespace MASH { class RiskQ; }
namespace MASH { class ImagoQ; }
namespace MASH { class EggQ; }
namespace MASH { class EL4P; }
namespace MASH { class MosquitoFemaleHistory; }

namespace Rcpp {
template <typename T> SEXP wrap(const MASH::RcppR6::RcppR6<T>&);
namespace traits {
template <typename T> class Exporter<MASH::RcppR6::RcppR6<T> >;
}

template <> SEXP wrap(const MASH::HumanEventQ&);
template <> MASH::HumanEventQ as(SEXP);
template <> SEXP wrap(const MASH::HistoryGeneric&);
template <> MASH::HistoryGeneric as(SEXP);
template <> SEXP wrap(const MASH::HistoryTravel&);
template <> MASH::HistoryTravel as(SEXP);
template <> SEXP wrap(const MASH::humanPfSI&);
template <> MASH::humanPfSI as(SEXP);
template <> SEXP wrap(const MASH::mosquitoPfSI&);
template <> MASH::mosquitoPfSI as(SEXP);
template <> SEXP wrap(const MASH::humanPfMOI&);
template <> MASH::humanPfMOI as(SEXP);
template <> SEXP wrap(const MASH::mosquitoPfMOI&);
template <> MASH::mosquitoPfMOI as(SEXP);
template <> SEXP wrap(const MASH::RiskQ&);
template <> MASH::RiskQ as(SEXP);
template <> SEXP wrap(const MASH::ImagoQ&);
template <> MASH::ImagoQ as(SEXP);
template <> SEXP wrap(const MASH::EggQ&);
template <> MASH::EggQ as(SEXP);
template <> SEXP wrap(const MASH::EL4P&);
template <> MASH::EL4P as(SEXP);
template <> SEXP wrap(const MASH::MosquitoFemaleHistory&);
template <> MASH::MosquitoFemaleHistory as(SEXP);
}

#endif
